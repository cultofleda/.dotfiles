# ---- bootstrap antigen
source $HOME/.dotfiles/zsh/antigen.zsh

# ----- start PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/share/fnm:$PATH"
# ----- end PATH

# ----- start globals
export XDG_CONFIG_HOME=$HOME/.config/
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PYENV_ROOT="$HOME/.pyenv"
export EDITOR="nvim"
# ----- end globals

# ----- start antigen-setup
antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle agkozak/zsh-z
antigen bundle command-not-found
# ----- end antigen-setup

# ----- start aliases
alias bat="batcat"
alias gcbr='git checkout $(git branch --sort=-committerdate | fzf --header "Checkout recent branch" --preview "git diff {1} --color=always" --pointer="❯")'
alias glgs="git rev-parse HEAD"
alias l="eza --long --icons --header --git --all --no-user"
alias ll="eza --long --icons --header --git --all"
alias lz="lazygit"
alias v="nvim"
alias zj="zellij"
# ----- end aliases

# ----- start pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# ----- end pnpm

# ----- start fnm
eval "`fnm env`"
# ----- end fnm

# ----- start fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# ----- end fzf

# ----- start pyenv
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv virtualenvwrapper_lazy
# ----- end pyenv

# ----- start zellij-autostart
eval "$(zellij setup --generate-auto-start zsh)"
# ----- end zellij-autostart

# ----- start prompt
eval "$(starship init zsh)"
# ----- end prompt

# ----- commit to antigen
antigen apply
