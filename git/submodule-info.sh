#!/bin/bash
echo -e "NAME\tPATH\tBRANCH\tCOMMIT"
git config --file .gitmodules --get-regexp '^submodule\..*\.path$' | while read -r key path; do
  name=${key#submodule.}
  name=${name%.path}
  branch=$(git config --file .gitmodules --get submodule.$name.branch)
  commit=$(git ls-tree HEAD "$path" | awk '{print $3}')
  echo -e "$name\t$path\t${branch:-<not set>}\t$commit"
done
