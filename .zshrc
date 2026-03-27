export LANG=ja_JP.UTF-8
export APP_ENV=local

# --------------------------------------------------
# History
# --------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

# --------------------------------------------------
# PATH (deduplicated & ordered)
# --------------------------------------------------
typeset -U path PATH

export GOPATH="$HOME/go"
export NVM_DIR="$HOME/.nvm"

path=(
  $HOME/.npm-global/bin
  $GOPATH/bin
  /opt/homebrew/opt/postgresql@15/bin
  /opt/homebrew/opt/mysql@8.0/bin
  /opt/homebrew/opt/libpq/bin
  $path
)

# --------------------------------------------------
# Completion (fast)
# --------------------------------------------------
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt list_packed

# --------------------------------------------------
# Behavior
# --------------------------------------------------
setopt no_beep
DIRSTACKSIZE=100
setopt AUTO_PUSHD
setopt hist_reduce_blanks
setopt inc_append_history
setopt noclobber

# --------------------------------------------------
# Aliases
# --------------------------------------------------
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias python="python3"

# --------------------------------------------------
# External Tools
# --------------------------------------------------
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# --------------------------------------------------
# Prompt & Navigation
# --------------------------------------------------
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# --------------------------------------------------
# Custom Functions
# --------------------------------------------------
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}

zle -N select-history
bindkey '^r' select-history

function cd() {
  if [ $# -eq 0 ]; then
    dir=$(zoxide query -l | fzf)
    [ -n "$dir" ] && builtin cd "$dir"
  else
    builtin cd "$@"
  fi
}

