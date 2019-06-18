#!/usr/bin/env bash

# Use this when the names are the same
function install_package() {
  local name=$1

  brew_install "$name"
}

function command_exists() {
  local name=$1

  command -v "$name" >/dev/null 2>&1
}
