# ======== Cache directory (for oh-my-zsh plugins) =========
[ ! -d $HOME/.zcustom/cache ] && mkdir -p $HOME/.zcustom/cache

export ZSH="$HOME/.zcustom"
export ZSH_CACHE_DIR="$ZSH/cache"

# GSA Settings
export GSA_USERNAME=davida.marion@gsa.gov
export AWS_PROFILE=master
export AWS_VAULT_PROMPT=ykman
export AWS_VAULT_KEYCHAIN_NAME=login
export YKMAN_OATH_CREDENTIAL_NAME=$(ykman oath accounts list)
export LOGIN_IAM_PROFILE=power
export AWS_IAM_USER=davida.marion
alias go-idp="cd ~/code/login/identity-idp && git pull && make update"
alias yubi="ykman oath accounts code arn:aws:iam::davida.marion:mfa/davida.marion"
# ======== Random settings ===========

# Disable auto title so tmux window titles don't get messed up.
export DISABLE_AUTO_TITLE="true"

# Maintain a stack of cd directory traversals for `popd`
setopt AUTO_PUSHD

# Allow extended matchers like ^file, etc
set -o EXTENDED_GLOB

# ========= History settings =========
if [ -z "$HISTFILE" ]; then
  HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt inc_append_history
setopt share_history # share command history data
setopt extended_glob

# =========== Plugins ============
source $HOME/.zsh/vendor/antigen.zsh

antigen bundle robbyrussell/oh-my-zsh plugins/git
antigen bundle robbyrussell/oh-my-zsh plugins/nvm
antigen bundle robbyrussell/oh-my-zsh plugins/pyenv
antigen bundle robbyrussell/oh-my-zsh plugins/rvm
antigen bundle robbyrussell/oh-my-zsh plugins/vi-mode
antigen bundle robbyrussell/oh-my-zsh plugins/zsh_reload

antigen bundle dbalatero/fzf-git
antigen bundle DarrinTisdale/zsh-aliases-exa
antigen bundle chriskempson/base16-shell
antigen bundle wookayin/fzf-fasd
antigen bundle twang817/zsh-ssh-agent
antigen bundle zsh-users/zsh-completions
antigen bundle zdharma-continuum/fast-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"
eval "$(fasd --init auto)"

export PATH="/usr/local/sbin:$PATH"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

GPG_TTY=$(tty)
export GPG_TTY

# ======= Python
# TODO: add a python installer
# installing pyenv
# export PATH="/Users/davidammarion/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/maven@3.5/bin:$PATH"

# Current postgres version
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ======= RVM is a special snowflake and needs to be last ========
if [ ! -f ~/.config/dotfiles/rbenv ]; then
  export PATH="$HOME/.rvm/bin:$PATH"
  [ -f ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm
fi
