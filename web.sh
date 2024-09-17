#!/bin/bash

# check if current directory is a git repository
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "Not a git repository. Exiting."
    exit 1
fi

# check if there is a remote origin configured for the current repository
if ! git remote -v | grep -qE '^\S+\s+\S+'; then
    echo "No remote set up for the git repository. Exiting."
    exit 1
fi

REPO_URL=$(git config --get remote.origin.url)

if [[ "$REPO_URL" == *"@"* ]]; then
    # it is a ssh url
    REPO_URL=${REPO_URL//:/\/}  # replace : with /\ in the URL
    REPO_URL=${REPO_URL/#git@/https:\/\/}  # add https:\/\/ for git@ URLs
else
    # it is a https url, and does not need any further modification
    :
fi

open -a Safari $REPO_URL
