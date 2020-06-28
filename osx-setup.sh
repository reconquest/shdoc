#!/usr/bin/env bash

if [[ -d ${HOME}/.bashmatic  ]];  then
  export bashmatic_already_installed=1
else
  export bashmatic_already_installed=0
fi

[[ -d ~/.bashmatic ]] || bash -c "$(curl -fsSL https://bit.ly/bashmatic-1-2-0)"

source ~/.bashmatic/init.sh

# remove  bashmatic after the install
(( bashmatic_already_installed )) || trap 'rm -rf ~/.bashmatic' EXIT

[[ -n $(command -v brew) ]] || brew.install
[[ -n $(command -v gawk) ]] || {
  info "installing GNU awk..."
  brew.install.package gawk
}

# relink it juist in casse
run "brew unlink gawk && brew link gawk || true"

export PATH="/usr/local/bin:${PATH}"



