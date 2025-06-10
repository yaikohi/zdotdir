#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# --- If Powerlevel10k: Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Lazy-load (autoload) Zsh function files from a directory.
ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
ZCOMPDIR=${ZDOTDIR:-$HOME}/.zcompletions
fpath=($ZFUNCDIR $fpath)
fpath=($ZCOMPDIR $fpath)
autoload -Uz $ZFUNCDIR/*(.:t)

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# Source anything in .zshrc.d.
for _rc in ${ZDOTDIR:-$HOME}/.zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc

# --- If Powerlevel10k uncomment:
# To customize prompt, run `p10k configure` or edit .p10k.zsh.
# [[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

# fnm
FNM_PATH="/home/ykhi/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/ykhi/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd)"
fi
# --- Starship
eval "$(starship init zsh)"
# --- direnv
eval "$(direnv hook zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# bun completions
[ -s "/home/ykhi/.bun/_bun" ] && source "/home/ykhi/.bun/_bun"

# fnm
FNM_PATH="/home/ykhi/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/ykhi/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
# GoLang Path
export PATH=$PATH:/usr/local/go/bin
