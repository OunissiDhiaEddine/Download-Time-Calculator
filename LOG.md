# Log

## 2026-10-08
- Inspected repo: SwiftUI app, MVVM, iOS 26 target, 5 prior commits, no tests.
- Wrote PLAN.md with goals, modernization steps, features, and milestones.
- M2 core: added KB size unit and MB/s speed unit, efficiency factor in the calculator, `Sendable` models, size/speed presets, shared `NumberParser`, and an `@Observable` view model that computes results live and remembers the last inputs.
- M3 UI: replaced the gradient and Calculate button with a simple grouped layout; result card on top updates live. Added preset chips, "Done around" time, share link, real-world speed slider, and an "At other speeds" list.
- M4 polish: accessibility labels, keyboard dismissal, README, and `Tests/` with Swift Testing cases (needs a test target added in Xcode).
- Not verified: no Swift toolchain was available, so nothing has been compiled. Please build in Xcode and report any errors.
