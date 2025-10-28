# MVP Scope

Map of core capabilities targeted for the initial MVP versus stretch goals considered for post-MVP releases.

## Checklist Management

| Classification | Capability | Acceptance Criteria |
| -------------- | ---------- | ------------------- |
| MVP | Generate trip checklists from imported itinerary metadata. | When a user imports calendar/email details, a trip is created with a baseline packing/tasks checklist organized by category. |
| MVP | Adapt checklist content based on weather, traveler profile, and trip purpose. | Given a trip with metadata and connected weather/profile data, generated items reflect contextual adjustments with rationale annotations. |
| MVP | Allow travelers to edit, reorder, and save personalized templates. | Users can modify checklist items, persist those edits to templates, and reapply templates to future trips. |
| Stretch | Support collaborative assignments with role-based permissions and audit trails. | Collaborators can be invited, assigned items, and their activity history is visible with timestamped updates. |
| Stretch | Provide export/import options for enterprise checklist standards. | Users can export checklists to CSV/PDF and import organization-approved templates without data loss. |

## Reminder Engine

| Classification | Capability | Acceptance Criteria |
| -------------- | ---------- | ------------------- |
| MVP | Configure multi-channel reminder preferences per trip. | Users can enable/disable push and email notifications, set quiet hours, and receive confirmation of preference changes. |
| MVP | Trigger reminders based on due dates and departure timeline urgency. | For items with due dates, reminders follow default cadence and accelerate as deadlines approach or tasks remain incomplete. |
| MVP | Surface proactive alerts for critical requirements with sufficient lead time. | System references visa/health databases and issues alerts at least the minimum processing lead time before departure. |
| Stretch | Add SMS and workplace chat integrations with escalation workflows. | Users can opt into SMS or Slack/Teams reminders, and critical alerts escalate automatically if unacknowledged. |
| Stretch | Introduce machine learning to predict likely forgotten items. | Model generates ranked suggestions and explanations, and users can accept or dismiss recommendations. |

## Insights Dashboard

| Classification | Capability | Acceptance Criteria |
| -------------- | ---------- | ------------------- |
| MVP | Display real-time trip readiness with completion metrics. | Dashboard shows percentage complete, overdue items, and upcoming deadlines for the active trip. |
| MVP | Highlight collaborator status for shared trips. | Assignee-level progress and outstanding items are visible with filters for person or category. |
| Stretch | Provide historical trends and recommendations. | Users can view reports of past trips, see recurring issues, and receive template/reminder suggestions. |
| Stretch | Enable exportable readiness summaries for stakeholders. | Users can export PDF/CSV reports capturing key metrics, charts, and risk indicators for selected trips. |
