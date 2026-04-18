#!/usr/bin/env bash
set -euo pipefail

REPO="tdubb123/claude-github-demo"
BASE="main"

require_clean_main() {
  git checkout "$BASE" --quiet
  git pull origin "$BASE" --quiet 2>/dev/null || true
}

make_branch() {
  local branch="$1"
  git checkout -b "$branch" --quiet 2>/dev/null || git checkout "$branch" --quiet
}

push_pr() {
  local branch="$1" title="$2" body="$3"
  git push -u origin "$branch" --quiet --force
  # Create PR only if it doesn't already exist
  if ! gh pr list --repo "$REPO" --head "$branch" --json number -q '.[0].number' | grep -q '[0-9]'; then
    gh pr create --repo "$REPO" --base "$BASE" --head "$branch" \
      --title "$title" --body "$body"
  else
    echo "PR for $branch already exists, skipping."
  fi
}

echo "==> Seeding demo PRs against $REPO..."

# --- PR 1: missing test coverage ---
require_clean_main
make_branch "feature/add-modulo"
cat >> src/calculator.js <<'JS'

function modulo(a, b) {
  if (b === 0) throw new Error('Modulo by zero');
  return a % b;
}
module.exports.modulo = modulo;
JS
git add src/calculator.js
git commit -m "feat: add modulo function" --quiet
push_pr "feature/add-modulo" \
  "feat: add modulo operation" \
  "Adds a \`modulo(a, b)\` function to the calculator. No tests written yet — wanted to get a review first."

# --- PR 2: no error handling for sqrt of negative ---
require_clean_main
make_branch "feature/sqrt-negative"
cat >> src/calculator.js <<'JS'

function sqrt(n) {
  return Math.sqrt(n);
}
module.exports.sqrt = sqrt;
JS
cat >> src/calculator.test.js <<'JS'

describe('sqrt', () => {
  test('square root of 4', () => expect(require('./calculator').sqrt(4)).toBe(2));
});
JS
git add src/calculator.js src/calculator.test.js
git commit -m "feat: add sqrt function" --quiet
push_pr "feature/sqrt-negative" \
  "feat: add square root" \
  "Adds \`sqrt(n)\`. Returns \`NaN\` for negatives — not sure if that's the right behaviour."

# --- PR 3: hardcoded secret ---
require_clean_main
make_branch "feature/hardcoded-secret"
cat > src/api-client.js <<'JS'
'use strict';

const API_KEY = 'sk-prod-4xR9mK2nVbLqTzWpJcYsDfUeAhOiNgXr';

async function fetchRate(from, to) {
  const url = `https://api.example.com/rates?from=${from}&to=${to}&key=${API_KEY}`;
  const res = await fetch(url);
  return res.json();
}

module.exports = { fetchRate };
JS
git add src/api-client.js
git commit -m "feat: add currency rate client" --quiet
push_pr "feature/hardcoded-secret" \
  "feat: add currency exchange rate client" \
  "Quick implementation of a rate-fetching client. Uses the prod API key directly for now."

# --- PR 4: regression in divide ---
require_clean_main
make_branch "feature/fix-divide"
# "fix" that actually breaks integer division
sed -i.bak 's/return a \/ b;/return Math.floor(a \/ b);/' src/calculator.js
rm -f src/calculator.js.bak
git add src/calculator.js
git commit -m "fix: ensure divide returns integer" --quiet
push_pr "feature/fix-divide" \
  "fix: make divide always return integer" \
  "Users reported confusion with float results. Changed to use \`Math.floor\` so divide always returns a whole number."

echo ""
echo "Done! Four demo PRs created on $REPO."
gh pr list --repo "$REPO"
