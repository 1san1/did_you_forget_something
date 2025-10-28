# Architecture Overview

"Did You Forget Something?" is delivered as a cloud-hosted, TypeScript-first platform composed of a React/Next.js web client, a modular NestJS API, and dedicated background workers for reminder delivery and external data ingestion. The architecture favors clear domain boundaries, observable message flows, and infrastructure primitives that can scale with seasonal travel demand while staying operable by a small team.

## System Context

- **Web Client (Next.js + React):** Provides authenticated trip planning, checklist editing, and notification preference management. Server-side rendering keeps first paint fast for time-sensitive reminder reviews, while client-side hydration unlocks responsive list editing and offline-friendly experiences.
- **API Gateway (NestJS HTTP + GraphQL):** Exposes a typed contract for the web client and future mobile apps. Public requests traverse API modules that orchestrate domain services, enforce authorization policies, and emit audit events.
- **Background Services:** Workers subscribe to domain events via Redis/BullMQ to schedule reminders, reconcile calendar/email imports, poll weather/visa providers, and send outbound notifications through channel-specific adapters.
- **Data Stores:** PostgreSQL persists core domain entities (trips, checklists, reminders, collaborators). Redis caches personalization inputs (weather snapshots, template suggestions) and powers delayed job queues. Object storage (S3-compatible) retains structured exports and large itinerary artifacts.
- **Integrations:** OAuth-connected calendar/email providers supply itinerary seeds. Third-party APIs (OpenWeather, Sherpa/Timatic visa data, Twilio/SendGrid) are isolated behind adapters with rate-limit guards and circuit breakers.

## Application Layers

1. **Presentation Layer:** Next.js pages route to feature-based UI modules (Trips, Checklist, Reminders, Insights). Components rely on design tokens and localized copy pulled from a shared CMS space.
2. **Experience API Layer:** NestJS resolvers/controllers map HTTP/GraphQL requests to application services, handle validation through DTO schemas (class-validator + Zod), and mediate access control via policy guards.
3. **Domain Layer:** Encapsulates core business rules through aggregate roots (Trip, Checklist, ReminderPolicy) and deterministic services (ChecklistGenerator, ReminderPlanner). Domain events capture state transitions and are persisted for replay.
4. **Infrastructure Layer:** Provides adapters for persistence (Prisma + PostgreSQL), messaging (BullMQ/Redis), third-party APIs, and observability (OpenTelemetry, Prometheus).

## State Management Rationale

### Client State
- **React Query for Server State:** Trips, checklists, and reminder schedules originate from the API and benefit from caching, background refetches, and mutation hooks. React Query's stale-time controls map well to travel timelines (e.g., aggressive refetch near departure, relaxed cadence afterward).
- **Zustand for UI/Session State:** Lightweight shared state (wizard progress, optimistic checklist edits before sync, notification preference forms) lives in a Zustand store to avoid Redux boilerplate while retaining predictable updates. Zustand snapshots can be persisted to IndexedDB for offline checklist review at airports.
- **URL & Form State:** Next.js routing with search params and React Hook Form keep transient UI state colocated with components, minimizing global store churn.

### Server State
- **PostgreSQL as Source of Truth:** Strong consistency guarantees ensure collaborators see the same checklist status, while JSONB columns capture contextual metadata (weather rationale, personalization explanations).
- **Event-Sourced Reminder Planning:** ReminderPlanner emits immutable events (`ReminderScheduled`, `ReminderEscalated`, `ReminderAcknowledged`) saved to an event log table. Workers rebuild the pending schedule from events, enabling auditability and easy recalculation when trip details change.
- **Cache & Job State in Redis:** Redis stores short-lived tokens (calendar ingest cursors) and delayed jobs. BullMQ's job metadata provides backpressure signals and retry policies without burdening PostgreSQL.

## Module Boundaries

| Module | Responsibilities | External Interfaces |
| --- | --- | --- |
| **Trip Intake** | Normalize calendar/email payloads, deduplicate itineraries, derive trip context (destination, participants, dates). | Ingest workers consume provider webhooks, API exposes mutation for manual trip creation. |
| **Checklist Engine** | Generate adaptive checklists, apply traveler profile rules, track item lifecycle (created, snoozed, completed). | REST/GraphQL operations for CRUD, domain events (`ChecklistItemUpdated`). |
| **Template Library** | Manage reusable packing/task templates, support personalization tokens, version template changes. | CRUD endpoints, admin UI, CDN-backed export of template manifests. |
| **Reminder Engine** | Calculate reminder cadence, enqueue jobs, process acknowledgements, escalate overdue tasks. | Consumes `ChecklistItemDue` events, publishes jobs to BullMQ queues, exposes metrics to Prometheus. |
| **Notification Gateway** | Abstract channel providers (email, push, SMS), render notification content, enforce quiet hours and consent. | Worker adapters for Twilio/SendGrid/Web Push, inbound webhook handlers for delivery receipts. |
| **Collaboration & Insights** | Track collaborator roles, aggregate progress metrics, generate readiness dashboards and exports. | GraphQL queries for dashboards, background exporter writing CSV/PDF to object storage. |
| **Platform & Observability** | Authentication (Cognito/Auth0), feature flagging, logging, metrics, tracing. | Middleware for API/worker services, dashboards in Grafana, alerting via PagerDuty. |

## Cross-Cutting Concerns

- **Security & Compliance:** PII encryption at rest, tokenized OAuth secrets, role-based access enforced at resolver guard level, and audit logs emitted on every checklist or reminder change.
- **Resilience:** Circuit breakers around third-party APIs with fallbacks (e.g., cached weather), idempotent command handlers, and chaos tests on reminder queues to ensure escalations fire even during outages.
- **Observability:** OpenTelemetry spans trace trip creation through checklist generation to reminder dispatch. Structured logs correlate user, trip, and job IDs to speed incident response.
- **Scalability:** Stateless API pods scale horizontally. BullMQ partitioning by trip ID ensures reminder jobs stay ordered per traveler while allowing cross-trip parallelism.
