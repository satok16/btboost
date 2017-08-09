#!/bin/bash -e

# Error on uninitialized variables..
set -o nounset

if [[ ! $1 ]]; then
  echo "Need one input for commit message."
  exit 1
fi

echo "commit message = $@"

git commit -a -m "$@"

git push origin master

git show HEAD --name-only| head -n 1
