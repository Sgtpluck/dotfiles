function brew_install() {
  local package=$1
  local expected_executable=${2:-$package}
  local command_prefix=${3:-brew}

  if test ! $(command -v $expected_executable); then
    echo "+ brew install $package"
    $command_prefix install "$package"
  else
    echo "+ $package already installed"
  fi
}

function brew_cask_install() {
  brew_install "$1" "$2" "brew cask"
}
