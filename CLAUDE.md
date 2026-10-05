<!--
  TEMPLATE — copy this to a project's ./CLAUDE.md (or ./.claude/CLAUDE.md).
  The two @import lines pull in the shared standards by absolute path.

  ONE-TIME APPROVAL: ~Standards is outside each project's directory, so the
  first Claude Code session after you add these imports shows an "external
  imports" approval dialog listing the two files — accept it. It appears once
  per project. (Ref: code.claude.com/docs/en/memory → "Import additional files".)

  PRECEDENCE: imports are expanded where the @ lines sit (top), so the central
  standards load first and the project-specific sections below are read last.
  A project section may TIGHTEN a central rule; it must never silently loosen
  one. If a project truly needs to contradict a central rule, change the central
  rule instead — raise it, don't fork.

  These HTML comments are stripped before the file enters Claude's context, so
  they cost no tokens. Rename the heading and fill the two sections; delete the
  stub lines you don't use.
-->

# TicTacToe

@/Users/hasanedain/Documents/NPCDevelopment/~Standards/Engineering.md
@/Users/hasanedain/Documents/NPCDevelopment/~Standards/Interaction.md
<!-- Release recipe: keep for anything that may ship to the App Store; delete for demos and tools that never will. -->
@/Users/hasanedain/Documents/NPCDevelopment/~Standards/Recipes/Release.md

## Project-specific engineering

- **Platform:** SwiftUI app for iPhone and iPad (`SDKROOT = iphoneos`). No Swift
  packages, no third-party dependencies.
- **Shape:** the human plays X and moves first; the machine plays O. The game
  rules (board state, win / tie detection) live in the model, the machine
  opponent's move choice lives in `MachineMove`, and views only render and
  forward taps.
- **Tile art** comes from the asset catalog: `Empty`, `PlayerX`, `PlayerO`.
- **Legacy code is not precedent.** The code predates `~Standards`; `PLAN.md`
  tracks bringing it into compliance. Until a plan item lands, don't copy the
  existing patterns it targets into new code — new code follows the standards.

## Project-specific interaction

- **Purpose:** a demo / exploration project, not a commercial release. It may be
  released for demo purposes.
