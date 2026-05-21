# Antigravity Global Rules

## 1. Environment & Context Detection
Before making any file changes or planning a task, you MUST check the `$__CFBundleIdentifier` environment variable to determine your execution context:
- **Standalone App (Agent Manager):** If `$__CFBundleIdentifier` is `com.google.antigravity`, you are running in the Standalone App and MUST default to **Autonomous & Parallel Mode (Task Isolation)**.
- **IDE App:** If `$__CFBundleIdentifier` is `com.google.antigravity-ide`, you are running in the IDE and MUST default to **Active Branch Editing (Direct Workspace Mode)**.
- **CLI/Terminal:** If `$__CFBundleIdentifier` is empty or matches any other value, you are running in the CLI or an external terminal shell.

---

## 2. Default Workspace Mode (IDE App & Standard CLI)
- **Active Branch Editing:** By default, when running inside the IDE (where `$__CFBundleIdentifier` is `com.google.antigravity-ide`) or during standard CLI commands, apply all changes directly to the user's active file buffers and current active branch.
- **Immediate Visibility:** The user expects to see and review these edits in real-time in their active editor. Do NOT create branches or worktrees unless explicitly requested.

---

## 3. Autonomous & Parallel Mode (Standalone App, CLI, & Explicit Requests)
- **Task Isolation:** You MUST isolate the environment by creating a new Git branch and checking it out in a dedicated Git worktree ONLY when:
  1. You are running inside the Standalone App (where `$__CFBundleIdentifier` is `com.google.antigravity`).
  2. You are running in the IDE or CLI and the user explicitly requests background/isolated execution (e.g., using terms like "run in the background", "work on a separate branch", "isolated task", or utilizing the `/goal` command).
- **Dedicated Scoped Worktrees:** All isolated task worktrees must live strictly inside:
  `~/.gemini/antigravity/worktrees/<repository-name>-<conversation-id>/`
- **Continuity & Reuse:** If a conversation thread ALREADY has an active isolated branch/worktree established, all subsequent messages, replies, or `/goal` commands inside that same thread MUST continue to use the **existing** branch and worktree. Do NOT create a new branch or worktree for subsequent turns within the same conversation.

---

## 4. Worktree Cleanup & Anti-Bloat Policy
- **Thorough Purge:** Before removing any temporary worktree folder, you MUST delete heavy generated folders (e.g., `node_modules/`, `.next/`, `dist/`, `build/`) and run `git clean -fdx` within the worktree to ensure no untracked binaries are left on disk.
- **Strict Lifecycle:** Never use the `--force` flag with `git worktree remove` to bypass cleaning up untracked directories.

---

## 5. Global Configuration & Dotfiles Management
- **Stow Integration:** Any time a global configuration file is created, modified, or required (e.g., shell configurations like `.zshrc`, multiplexer setups, editor configs, or agent system rules), you MUST store it inside the user's centralized dotfiles repository:
  `/Users/dskoziol/Documents/Code/github/dskoziol/dotfiles/`
- **Package Organization:** Place the configuration file within the appropriate package folder inside the dotfiles repository, matching its relative path under the home directory (e.g., `dotfiles/<package-name>/.config/...` or `dotfiles/<package-name>/.gemini/...`).
- **Symlink Creation:** Always use GNU Stow to symlink the configuration file from the dotfiles repository back to its target global path in the home directory (`~`).
- **Version Control:** Ensure all new or updated configuration files are added and committed to the Git history of the dotfiles repository.
