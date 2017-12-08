#!/bin/bash -e

# Error on uninitialized variables..
set -o nounset

echo 'hint: git commit -a -m "fix dep" && ./push.sh'

git push origin master

git show HEAD --name-only| head -n 1
