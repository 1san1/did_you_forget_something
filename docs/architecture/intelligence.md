# Intelligence Engine

This note outlines the first iteration of the heuristic services that personalize checklist suggestions and measure traveler streaks before machine learning models are introduced.

## Suggestion Heuristics
- **Context Inputs:** Destination climate (weather API snapshot), trip duration, traveler profile tags (business, family, medical needs), historical item selections, and routine templates.
- **Scoring:** Each candidate item receives a weighted score derived from recency of prior use, alignment with traveler profile tags, and destination-specific modifiers (e.g., cold-weather multiplier). Thresholds gate automatic additions versus soft nudges.
- **Conflict Resolution:** When scores tie or exceed capacity (e.g., limit of new items per trip), preferences favor items from active routines, then from personal history, and finally from global templates.
- **Feedback Loop:** User dismissals decrement weightings for similar contexts, while completions reinforce relevance. Feedback events are persisted in `ItemHistory` and summarized nightly to adjust weight tables.

## Streak Tracking
- **Definition:** A streak represents consecutive completion windows (daily for routines, trip phases for ad-hoc checklists) where all critical items were acknowledged before their due time.
- **Data Sources:** Derived from `ItemHistory` transitions combined with reminder acknowledgement timestamps. A cache of streak counters lives in Redis for quick retrieval.
- **Heuristic Rules:**
  - Increment streak when all items marked `critical` for the window transition to `completed` before their `dueAt`.
  - Break streak only after a grace period expires (default 6 hours) to allow late acknowledgements triggered by reminders.
  - Award bonus streak points for consecutive on-time completions of the same routine to feed motivational messaging.
- **Surfacing Insights:** The engine emits `StreakUpdated` events consumed by the insights dashboard and notification service, which then tailor encouragement copy or suggest collaborative interventions.
