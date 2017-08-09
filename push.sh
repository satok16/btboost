#!/bin/bash -e

# Error on uninitialized variables..
set -o nounset

git push origin master

git show HEAD --name-only| head -n 1
