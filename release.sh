#!/bin/bash

MAJOR="19"
MINOR="0"

LAST_COMMIT_DATE="$1"

if [ -z "$LAST_COMMIT_DATE" ]; then
  echo "Usage: $0 <YYYY-MM-DD>"
  exit 1
fi

LAST_GIT_COMMIT=$(git log -1 --until="$LAST_COMMIT_DATE" --pretty=format:"%H")

if [ -z "$LAST_GIT_COMMIT" ]; then
  echo "Error: No commits found before $LAST_COMMIT_DATE"
  exit 1
fi

PATCH=$(echo "$LAST_COMMIT_DATE" | sed "s/-//g")

VERSION="$MAJOR.$MINOR.$PATCH"

git tag -a $VERSION $LAST_GIT_COMMIT -m "Odoo weekly rolling release $VERSION"

echo "Odoo weekly rolling release $VERSION"

git push origin $VERSION

git cliff 19.0.20260118..HEAD -o CHANGELOG.md