# prompt
autoload -U colors && colors
PS1="%B%{$fg[blue]%}[%{$fg[red]%}%n%{$fg[green]%}@%{$fg[red]%}%M%{$fg[blue]%}]%{$fg[green]%}(%{$fg[magenta]%}%~%{$fg[green]%})%{$fg[black]%}$%{$reset_color%}%b "

# history
HISTFILE=$HOME/.cache/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

# vi mode
bindkey -v
export KEYTIMEOUT=1

# tab completion
autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit

# vim keys for tab completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# shell variables
export PATH="$PATH:$HOME/.local/bin/:$HOME/.cargo/bin/"
export EDITOR="nvim"

# aliases
alias ls="ls --color=auto -CF"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"
alias ll="ls -lah"

alias rm="safe_rm"
alias nc="ncat"
alias r="ranger"
alias die="poweroff"
alias please="sudo"
alias ropgadget="ROPgadget"

alias gs="git status"
alias gc="git commit -a"

# keybinds
bindkey -s "^p" "swd\n"
bindkey -s "^r" "ranger\n"
bindkey -s "^b" "btop\n"
bindkey -s "^l" "clear\n"


# save wd
swd() {
	pwd > $HOME/.cache/saved_wd
}

# automatically create a dir and cd to it
mkcd() {
  mkdir $@ && cd $_
}

# create a temporary directory and cd to it
tmpdir() {
	cd $(mktemp -d)
}

# load plugins
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# cd to saved wd on shell-start
cat $HOME/.cache/saved_wd
cd $(cat $HOME/.cache/saved_wd)
