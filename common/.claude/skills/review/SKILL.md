---
name: branch-review
description: Review a git branch against master/main. Use when the user wants a code review of branch changes before merging.
---

# Branch Review Skill

## Inputs
- **Repo path** — ask if not provided
- **Branch name** — ask if not provided
- **Base branch** — default `master`, fallback `main`

## Workflow

### 1. Get the diff
```bash
cd <repo_path>
git log --oneline <base>..<branch>   # commits overview
git diff --stat <base>...<branch>    # files changed
git diff <base>...<branch>           # full diff
```
Skip generated/lock files. If diff is huge, focus on core logic files.

### 2. Review these areas
- **Bugs & correctness** — edge cases, null handling, logic errors
- **Security** — injection, hardcoded secrets, input validation
- **Code quality** — readability, duplication, dead code
- **Tests** — are new behaviors covered?
- **Performance** — N+1s, unnecessary loops

### 3. Output format
```markdown
# Branch Review: `<branch>` → `<base>`

## Summary
<What does this branch do?>

## 🔴 Blocking Issues
<Must fix before merge. Or: None.>

## 🟡 Suggestions
<Non-blocking improvements.>

## Merge Recommendation
✅ Approve / 🔁 Approve with suggestions / ❌ Request changes
```

Save to `/mnt/user-data/outputs/branch-review-<branch>.md` and present with `present_files`.
