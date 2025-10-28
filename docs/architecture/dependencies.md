# Critical Dependencies

The platform relies on a focused set of frameworks and libraries that balance developer velocity with maintainability. The table below highlights the most critical packages, why they are central to the system, and what we must watch when operating them in production.

| Package | Layer / Module | Why We Use It | Maintenance Notes |
| --- | --- | --- | --- |
| **Next.js** | Web client (Presentation) | Provides hybrid SSR/ISR for checklist and reminder views, improving performance for travelers reviewing trips on unstable connections. Offers built-in routing and image optimization for itinerary assets. | Track Vercel LTS release cadence (upgrade each minor). Validate middleware changes against Auth0 integration. Budget load testing before enabling new app router features. |
| **React Query (@tanstack/react-query)** | Web client data layer | Manages server state caching for trips, checklists, and reminder timelines with minimal boilerplate and excellent mutation handling. | Keep dependencies aligned with React version. Monitor breaking changes in major v5 releases; wrap mutations with typed helpers to minimize churn. |
| **Zustand** | Web client shared state | Stores light-weight UI/session state (wizard steps, offline checklist edits) without Redux overhead, enabling optimistic UX while offline. | Audit middleware plugins (persist, immer) before upgrades. Ensure selectors remain serializable for devtools. |
| **React Hook Form** | Web client forms | Handles complex checklist and preference forms with high performance and minimal re-renders, including integration with Zod validation. | Pin to stable minor release; revalidate form schemas when upgrading due to potential API changes in resolver packages. |
| **NestJS** | API gateway & workers | Provides opinionated modular structure, dependency injection, and mature ecosystem for GraphQL/REST endpoints, background schedulers, and authentication guards. | Follow LTS releases; align with Node.js LTS. Run `nest update` preview in staging because decorators occasionally change typing requirements. |
| **Prisma** | Persistence (PostgreSQL) | Simplifies schema migrations and type-safe queries for trips, checklists, reminder policies, and event logs. | Review generated SQL before applying migrations in production. Stay within 2 minor versions of latest to receive security patches. |
| **BullMQ** | Reminder scheduling queues | Powers delayed reminder jobs, escalation workflows, and backpressure control via Redis streams. | Redis version upgrades must be coordinated; monitor queue latency metrics. Validate retention policies after BullMQ updates to avoid log growth. |
| **class-validator / class-transformer** | API DTO validation | Enforces request and message schemas at module boundaries, protecting domain services from malformed data. | Keep pairs in sync; major upgrades can change decorator metadata. Add regression tests for complex nested DTOs before bumping versions. |
| **Zod** | Shared validation | Provides runtime validation for checklist templates and reminder policies shared between client and server bundles. | Generate inference types automatically to prevent drift. Watch bundle size when adding refinements; tree-shake unused schemas. |
| **OpenTelemetry** | Observability | Instruments API calls, queue jobs, and external integrations for end-to-end tracing and metrics correlation. | Maintain collector configuration alongside version upgrades. Validate exporter compatibility (OTLP/gRPC) before bumping minor versions. |
| **SendGrid SDK / Web Push / Twilio SDKs** | Notification gateway | Channel-specific adapters to deliver reminders via email, push, and SMS with reliable delivery reporting. | Rotate API keys quarterly. Monitor SDK deprecations; run integration smoke tests whenever providers update webhook payload formats. |

## Operational Practices

- **Dependency Review:** Weekly automated scans (Dependabot + Snyk) feed into engineering triage. Security patches are merged within 48 hours.
- **Version Pinning:** All critical runtime packages are pinned to minor versions in `package.json` and upgraded through dedicated maintenance sprints after staging verification.
- **Backwards Compatibility Tests:** Contract tests (GraphQL schema diff, reminder scheduling replay) run in CI to ensure dependency upgrades do not alter public APIs or event payloads unexpectedly.
