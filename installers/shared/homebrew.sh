#!/usr/bin/env bash

arm64_packages=(
  rbenv
)

function contains_element() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

function brew_is_tapped() {
  local tap=$1

  ! is_macos && return 1

  brew tap | grep -q "$tap"
}

function brew_tap() {
  local tap=$1

  ! is_macos && return 1

  brew tap "$tap"
}

function brew_install() {
  local package=$1

  ! is_macos && return 1

  if brew list "$package" > /dev/null 2>&1; then
    dotsay "+ $package already installed... skipping."
  else
    if contains_element "$package" "${arm64_packages[@]}"; then
      arch -arm64 brew install $@
    else
      brew install $@
    fi
  fi
}

function brew_upgrade() {
  local package=$1

  ! is_macos && return 1

  dotsay "+ $package already installed... skipping."

  if contains_element "$package" "${arm64_packages[@]}"; then
    arch -arm64 brew upgrade $@
  else
    brew upgrade $@
  fi
}

function brew_cask_install() {
  local package=$1

  ! is_macos && return 1

  if brew list "$package" > /dev/null 2>&1; then
    dotsay "+ $package already installed... skipping."
  else
    brew install --cask $@
  fi
}

function brew_install_all() {
  local packages=("$@")

  ! is_macos && return 1

  for package in "${packages[@]}"; do
    brew_install $package
  done
}
