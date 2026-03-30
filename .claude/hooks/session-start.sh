#!/bin/bash
set -euo pipefail

# Only run in remote environments (Claude Code on the web)
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# Install PHP/Composer dependencies
# --ignore-platform-reqs: some PHP extensions (bcmath) may be unavailable in container
# --prefer-dist: avoid git clones that may be blocked by network restrictions
# Allow failure gracefully - drupalcode.org git may be blocked in container
if [ -f "composer.json" ]; then
  composer install --no-interaction --no-progress --prefer-dist --ignore-platform-reqs || {
    echo "Warning: composer install failed (likely network restrictions). Continuing..."
  }
fi
