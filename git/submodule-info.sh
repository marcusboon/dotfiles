#!/bin/bash

# CSV Header
echo "name,path,url,target_branch,current_branch,current_commit,status"

# Parse submodules
git config -f .gitmodules --get-regexp path | while read -r key path; do
    name=$(echo "$key" | sed 's/^submodule\.//;s/\.path$//')
    url=$(git config -f .gitmodules --get submodule."$name".url)
    branch=$(git config -f .gitmodules --get submodule."$name".branch)
    branch=${branch:-""}

    if [ -d "$path/.git" ]; then
        pushd "$path" > /dev/null

        current_branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
        current_commit=$(git rev-parse --short HEAD)
        status="initialized"

        popd > /dev/null
    else
        current_branch=""
        current_commit=""
        status="not initialized"
    fi

    # Output CSV line
    echo "\"$name\",\"$path\",\"$url\",\"$branch\",\"$current_branch\",\"$current_commit\",\"$status\""
done
