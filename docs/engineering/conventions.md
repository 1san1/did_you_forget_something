# Coding Conventions and Review Checklist

This guide codifies our expectations for Flutter/Dart contributions and the associated review process.

## Coding Conventions
- **Language Version:** Target the latest stable Dart version supported by the Flutter stable channel.
- **Project Structure:**
  - Group features by domain (`lib/features/<feature_name>`).
  - Share cross-cutting utilities in `lib/core/` (networking, theming, analytics).
- **Naming:**
  - Use `UpperCamelCase` for classes and enums, `lowerCamelCase` for variables and functions.
  - Prefix private members with `_`.
- **Formatting:**
  - Run `dart format .` before committing (enforced in CI).
  - Keep lines ≤ 100 characters unless readability suffers.
- **State Management:**
  - Prefer declarative patterns (e.g., Riverpod, Bloc, or Provider). Document chosen approach per feature.
- **Widgets:**
  - Extract reusable widgets into `lib/shared/widgets/`.
  - Keep build methods pure; avoid side effects.
- **Null Safety:**
  - Avoid `!` unless logically proven safe; prefer null-aware operators and guards.
- **Error Handling:**
  - Convert exceptions into typed failures and surface via `Either`/`Result` objects.
  - Log recoverable issues with `logger` package; escalate critical ones to monitoring (Sentry/Firebase Crashlytics).
- **Testing:**
  - Provide widget/unit tests for new behavior.
  - Use golden tests for critical UI components.
- **Documentation:**
  - Add `///` doc comments for public APIs.
  - Update `CHANGELOG.md` for user-visible changes.

## Git Practices
- Branch naming: `feature/<slug>`, `bugfix/<slug>`, `chore/<slug>`.
- Commit messages follow Conventional Commits (`feat:`, `fix:`, `chore:`, etc.).
- Keep commits scoped; avoid unrelated changes.

## Code Review Checklist
1. **Correctness**
   - Does the change satisfy acceptance criteria and specs?
   - Are edge cases handled (nulls, timeouts, offline scenarios)?
2. **Testing**
   - Do tests cover new logic and pass locally/CI?
   - Are mocks/stubs used appropriately?
3. **Performance**
   - Are expensive operations moved off the main isolate?
   - Are rebuilds minimized (memoization, `const` constructors)?
4. **Security & Privacy**
   - Are secrets, tokens, or PII omitted from logs?
   - Are network calls using TLS and validating certificates?
5. **Accessibility**
   - Are semantics labels provided for interactive widgets?
   - Are color contrasts compliant (WCAG AA)?
6. **Maintainability**
   - Is code readable, idiomatic, and DRY?
   - Are TODOs tracked with issue references?
7. **Documentation & Ops**
   - Are README/docs updated?
   - Are migration steps communicated (DB, feature flags)?
8. **Approvals & Releases**
   - Has at least one domain expert reviewed?
   - Are rollout steps (feature flags, staged rollout) defined?

## Reviewer Guidelines
- Provide actionable feedback with rationale.
- Praise what works well to reinforce good patterns.
- Use suggestions for small edits; request changes for blocking issues.
- Ensure CI status is green before approving.

