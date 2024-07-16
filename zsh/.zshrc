# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles
export EDITOR="nvim"

export OLLAMA_ORIGINS=*
export NODE_OPTIONS=--max-old-space-size=8192
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

export PGADMIN_DEFAULT_PASSWORD="admin"
export PGADMIN_DEFAULT_EMAIL="admin@localhost.com"
export PGADMIN_DEFAULT_PASSWORD_FILE="~/.pgadmin/passwd"

# ZSH
autoload -U add-zsh-hook

# plugins
plugins=(
  direnv
  docker
  env
  git
  tmux
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $DOTFILES/zsh/scripts/gli.sh
source $DOTFILES/zsh/scripts/gcbr.sh

# aliases
alias bat="batcat"
alias cat="batcat"
alias f="fzf --preview='batcat --style=numbers --color=always --line-range :500 --theme=\"Catppuccin Macchiato\" {}'"
alias gb="git_branch"
alias gc="git commit -S"
alias gcfo="git_checkout"
alias glg="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias glgs="git rev-parse HEAD"
alias l="eza --long --git --all --icons --no-user --group-directories-first"
alias ll="eza --long --git --all --icons --no-user --no-permissions --no-time --no-filesize --group-directories-first"
alias lz="lazygit"
alias mm="micromamba"
alias v="nvim"
alias zj="zellij"

# pnpm
export PNPM_HOME="/home/avazigin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "`fnm env --multi --use-on-cd --log-level=quiet`"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zellij autostart
eval "$(zellij setup --generate-auto-start zsh)"

# Starship prompt
# eval "$(starship init zsh)"
# oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.dotfiles/oh-my-posh/tokyonight_storm.omp.json)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# place default node version under $HOME/.node-version
load-nvmrc() {
  DEFAULT_NODE_VERSION=`cat $HOME/.node-version`
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    fnm use
  elif [[ `node -v` != $DEFAULT_NODE_VERSION ]]; then
    fnm use $DEFAULT_NODE_VERSION
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
