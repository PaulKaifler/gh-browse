#!/bin/bash

# check if current directory is a git repository
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then

    # check if there is a remote origin configured for the current repository
    if !(git remote >/dev/null 2>&1); then
        echo "No remote origin found" >&2
        exit 1
    fi

    REPO_URL=$(git config --get remote.origin.url)
    REPO_URL=${REPO_URL//:/\/}  # replace : with /\ in the URL
    REPO_URL=${REPO_URL/#git@/https:\/\/}  # add https:\/\/ for git@ URLs

    open -a Safari $REPO_URL

    unset REPO_URL

else
    echo "Current dir is not a git repository" >&2
    exit 1
fi
