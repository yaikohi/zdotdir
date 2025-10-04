#!/bin/zsh
#
# .aliases - Set whatever shell aliases you want.
#

# --- Reboot into UEFI
alias uefi="sudo systemctl reboot --firmware-setup"

# single character aliases - be sparing!
alias g=git

# mask built-ins with better defaults
alias vi=nvim
alias vim=nvim

# eza: 'ls' alternative; since 'exa' is deprecated.
alias l='eza'
alias ls="eza -1"
alias ll="eza -1a"
alias la="eza -a"
alias lr="eza -aR --git-ignore"
alias lt="eza -aT --git-ignore"

#
# --- UTILITIES
alias src='source $HOME/.zshrc'
alias supdg="sudo apt-get update && sudo apt-get upgrade"

#
# --- KUBERNETES / TALOSCTL
alias k="kubectl"
alias tl="talosctl"

#
# --- Git
alias gitf="git add . && git commit --amend --no-edit && git push -f"
#
# --- SurrealDB
alias srql="curl --request POST \
		--header 'Accept: application/json' \
		--header 'NS: test' \
		--header 'DB: test' \
		--user 'root:root' \
		--data '${DATA}' \
		http://localhost:8000/sql"

# --- Golang
alias setupgo="~/scripts/setupgo.sh"

# fix common typos
alias quit="exit"
alias cd..="cd .."

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# misc
alias please=sudo

# Config editing
alias starshipedit="cd $HOME/.config && nvim ."
alias zshrc="cd $ZDOTDIR && nvim .zshrc"
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias zdot='cd ${ZDOTDIR:-~}'

# --- connections
alias connectykhi="ssh ubuntu@$VPS_YKHI"
alias fixterminfo="infocmp -x xterm-ghostty | ssh ubuntu@$VPS_YKHI -- tic -x -"
