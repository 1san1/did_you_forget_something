# Domain Models

This document captures the core aggregates and supporting entities that anchor reminder orchestration and traveler workflows.

## Reminder
- **Purpose:** Represents a scheduled or ad-hoc prompt tied to a checklist item or trip-level milestone.
- **Key Attributes:** `id`, `tripId`, `checklistItemId?`, `channel` (email, push, SMS), `scheduledAt`, `status`, `priority`, `createdBy`.
- **Behavior:** Calculates next send time based on acknowledgement, snooze, or escalation rules; records delivery attempts and acknowledgements as domain events; enforces quiet hours and consent policies before dispatch.
- **Relationships:** Belongs to a `Checklist` or `Routine`. Emits `ReminderScheduled`, `ReminderEscalated`, `ReminderAcknowledged` events consumed by workers and analytics.

## Checklist
- **Purpose:** Aggregate root that encapsulates traveler tasks/items for a single trip, packing template, or shared routine.
- **Key Attributes:** `id`, `tripId?`, `ownerId`, `title`, `sourceTemplateId?`, `status` (draft, active, archived), `items[]`, `collaborators[]`, `tags`.
- **Behavior:** Applies personalization rules (traveler profile, destination context, weather); enforces item ordering and dependency constraints; propagates state changes (complete, snoozed, dismissed) to reminders and streak trackers.
- **Relationships:** Owns `ChecklistItem` value objects; links to `Reminder` schedules and `ItemHistory` timelines; may be associated with a reusable `Routine` template.

## Routine
- **Purpose:** Reusable blueprint describing recurring preparation flows (e.g., pre-flight checks, business travel pack list).
- **Key Attributes:** `id`, `organizationId?`, `name`, `description`, `version`, `defaultCadence`, `items[]`, `visibility` (private, shared, published).
- **Behavior:** Versioned to track edits across publishing cycles; exports localized or traveler-segmented variants; seeds new `Checklist` instances while retaining link to the originating routine for analytics.
- **Relationships:** Template for `Checklist` creation; shares `ItemDefinition` structures with the Template Library; informs suggestion heuristics when recommending additional items or reminders.

## ItemHistory
- **Purpose:** Immutable ledger of state transitions for a specific checklist item across edits, completions, and reminders.
- **Key Attributes:** `id`, `checklistItemId`, `occurredAt`, `previousState`, `nextState`, `actor` (user, system), `metadata` (acknowledgement context, snooze reason).
- **Behavior:** Enables audit trails, streak tracking, and machine learning features; supports temporal queries for calculating completion velocity or forecasting future reminders.
- **Relationships:** Linked to `ChecklistItem` and indirectly to `Reminder` executions; aggregated by the analytics service for insights dashboards.
