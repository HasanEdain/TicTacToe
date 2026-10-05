# TicTacToe — standards compliance plan

Bring the 2021 codebase into line with `~Standards` (`Engineering.md`,
`Interaction.md`). Leaves are in strict dependency order; "next" is the first
`- [ ]`.

## Milestone: standards compliance

**Done when:** every source file follows `Engineering.md` (no unchecked
subscripts, no silent failure paths, no magic numbers, one type per file, files
under ~200 lines, every view its own file with `#Preview`s covering every state),
the game rules and machine opponent have Swift Testing coverage, and the known
logic bugs below are fixed. **Status:** open.

**Done so far:** `.gitignore` added. New Game resets the tie flag (interim fix; `game-model` replaces it). Machine takes its own winning move before blocking (interim fix; `machine-move` replaces it). Dead `emptyCount() == 7` branch removed. "X won" preview uses its own board. Xcode recommended project settings applied (all targets on `$(RECOMMENDED_IPHONEOS_DEPLOYMENT_TARGET)`). `TicTacToeUITests` target deleted. Swift 6 language mode on all targets; app target defaults to `MainActor` isolation.

### Audit findings (what the leaves fix)

| Area | Finding | Where |
| --- | --- | --- |
| Illegal state | `player: TileState` accepts `.empty` as a player | `Board`, `MachineMove`, `BoardView` |
| Illegal state | `Board(tiles:)` accepts any length; win checks then index `tiles[0...8]` unchecked → crash | `Board.swift:13, 52-305` |
| Illegal state | Game outcome is three loose `@State` vars (`gameOver`, `tie`, `currentPlayer`) — root cause of the tie bug | `BoardView.swift:12-14` |
| Failure paths | `guard … else { return }` in `move` / `canMove` fail silently | `Board.swift:20-44` |
| Magic numbers | Raw tile indices throughout, `12` corner radius | `Board`, `MachineMove`, `BoardView` |
| Consolidate | 8 win lines hand-unrolled three times (`playerWon`, `firstBlockIndex`, `firstLineIndex`) | `Board.swift` (342 lines, over 200) |
| Consolidate | Nine hand-written `Tile` + `onTapGesture` calls; `firstMoveHeuristic` is nine copy-paste `if`s | `BoardView.swift:58-85`, `MachineMove.swift:53-106` |
| Dead code | `randomMove`, `animationDuration`, `applyAlpha`, `Tile.index`; `Tile`'s `@Binding` is never written | various |
| Apple-first | `ObservableObject`/`@Published`; `ContentView` holds it in `@State` while `BoardView` re-wraps it in `@StateObject` | `Board`, `ContentView`, `BoardView` |
| Views | `BoardView` holds three views (board, game-over, logic) in one file; game logic lives in the view | `BoardView.swift` |
| Previews | `PreviewProvider` instead of `#Preview`; no O-won state; mock state via `@State static` | all views |
| Testing | XCTest template stubs only, including a `measure {}` perf stub (standard: no premature perf tests) | `TicTacToeTests` |
| Repo | No `.gitignore`; `xcuserdata/` is tracked | repo root |

Fine as-is: `TileState.swift`, `TicTacToeApp.swift`, one type per file. Colors
are named (`.white`, `.blue`), not numeric. No text needs `.textSelection`:
everything visible is a short UI label.

### Leaves

- [ ] `untrack-xcuserdata` — `git rm --cached` the already-tracked `xcuserdata/` (`.gitignore` doesn't affect files already tracked).
- [ ] `swift-testing` — replace the XCTest stubs in `TicTacToeTests` with a Swift Testing suite; delete the `measure {}` stub. The app's types are now `MainActor`-isolated, so suites that touch them are `@MainActor`.
- [ ] `player-type` — introduce `Player` (`x`, `o`, with `opponent`) and make `TileState` `empty | occupied(Player)`; every `player:` parameter takes `Player`.
- [ ] `board-position` — model the board as a fixed nine-cell type addressed by a position type (not a raw `Int`), so out-of-range indices and wrong-length boards can't be represented; named positions replace magic indices.
- [ ] `board-logging` — add an OSLog `Logger` and log the remaining failure paths (e.g. moving onto an occupied cell).
- [ ] `board-tests` — Swift Testing coverage of the rules: every win line for each player, tie, not-a-tie-when-won, occupied-cell move, empty board.
- [ ] `win-lines` — one `static let` table of the eight lines; rewrite `playerWon` / `firstBlockIndex` / `firstLineIndex` over it (`board-tests` guards the rewrite). Gets `Board.swift` under 200 lines.
- [ ] `machine-move` — restructure move priority (win, then block, then line, then preference order) as explicit steps, express `firstMoveHeuristic` as an ordered position list, delete unused `randomMove`. Tests for each priority branch.
- [ ] `game-model` — an `@Observable` `Game` owning the board, the current player, and a `GameOutcome` (`inProgress` / `won(Player)` / `tie`), with the turn logic now in `BoardView.move`. Fixes the tie-not-reset bug by construction. Tests: X wins, O wins, tie, New Game resets everything.
- [ ] `view-split` — `ContentView` owns `Game` via `@State`; split into `BoardGridView` (iterate positions), `GameOverView`, and `Tile` as a plain value view inside a `Button`; one view per file; named constants (corner radius); remove dead view state.
- [ ] `previews` — `#Preview`s for every state: tiles (empty / X / O), board (empty / mid-game), game over (X won / O won / tie), and `ContentView`.
