#!/usr/bin/env bash

set -euo pipefail

mkdir -p /test && cd /test

echo "Initializing git"
git config --global init.defaultBranch "main"
git config --global user.email "test@example.com"
git config --global user.name "Test Some"
git init

TEST_TEXT="This is just a test"

printf "Initializing git-crypt\n"
git-crypt init
git-crypt export-key /tmp/test.key
echo "test.txt filter=git-crypt diff=git-crypt" > .gitattributes
git add .gitattributes
git commit -a -m "Adding .gitattributes"

printf "\nAdding test file\n"
echo -n $TEST_TEXT > test.txt
git add test.txt
git commit -a -m "Adding test file"

printf "\nTesting locked file\n"
git-crypt lock
[[ "${TEST_TEXT}" != "$(cat test.txt)" ]] || exit 1

printf "\nTesting unlocked file\n"
git-crypt unlock /tmp/test.key
[[ "${TEST_TEXT}" == "$(cat test.txt)" ]] || exit 1
