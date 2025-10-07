# https://github.com/cli/cli/issues/5292

OWNER="$1"
NEW_OWNER="${2:-andriyor}"

REPOS=$(gh repo list "$OWNER" --json owner,name  --jq '.[] | "\(.owner.login)/\(.name)"')

for REPO in $REPOS; do
  echo "➡️  Transferring $REPO ..."
  gh api "repos/${REPO}/transfer" -f new_owner="$NEW_OWNER" --silent || echo "⚠️ Failed to transfer $REPO"
done
