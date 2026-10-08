# Plan: Reviving Download Time Calculator

## Goals
- Bring the app up to date with current Swift / SwiftUI practices.
- Keep the UI simple: type a size, type a speed, see the time. Nothing else required.
- Add a handful of genuinely useful features without cluttering the main screen.

## Starting point (Oct 2026)
- SwiftUI app, iOS 26 target, Swift 5 language mode.
- `ObservableObject` view model with a manual **Calculate** button.
- Sizes: MB / GB / TB. Rates: Kbps / Mbps / Gbps only.
- Gradient background, material card, one result card.
- No tests, no persistence, no localization.

## Modernization
1. Move the view model to the Observation framework (`@Observable`).
2. Remove the Calculate button: the result updates live as the user types.
3. Make the pure logic (models, calculator, formatter) easy to test and `Sendable`.
4. Use `Duration`/`FormatStyle`-friendly formatting where it helps; keep locale-aware number parsing.
5. Remember last inputs between launches.
6. Tidy accessibility (labels, Dynamic Type friendly layout, VoiceOver result summary).

## Features
- More units: sizes KB/MB/GB/TB; speeds Kbps/Mbps/Gbps plus MB/s (bytes per second).
- Quick presets for common sizes (song, movie, game, OS update) and speeds (4G, Wi-Fi, 5G, gigabit).
- "Finishes at" clock time based on the estimate.
- Real-world efficiency slider (protocol overhead / congestion), default 100%.
- "At other speeds" list showing the same download at common connection speeds.
- Copy result.

## Milestones
1. **M1 Docs and setup** – this plan, LOG.md, repo hygiene (.gitignore, remove user state files).
2. **M2 Core** – new units, efficiency, Observation-based view model.
3. **M3 UI** – live results, presets, finish time, comparison list.
4. **M4 Polish** – persistence, accessibility, README.
5. **Later** – unit-test target, localization, widget/Shortcut, iPad layout.

## Constraints and notes
- Code could not be compiled in the authoring environment (no Swift toolchain); build and run in Xcode before merging.
- New files go into the existing synchronized folders so no project file edits are needed.
- Unit tests are written as plain files under `Tests/` ready to be attached to a test target in Xcode (adding the target needs Xcode).
