# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/ykhi/.config/zsh/completions:"* ]]; then export FPATH="/home/ykhi/.config/zsh/completions:$FPATH"; fi
#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

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

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
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
[ -s "$HOME/.bun/_bun" ] && source "/home/ykhi/.bun/_bun"

# --- Auto-start the SSH-agent !
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi

# GoLang Path
export PATH=$PATH:/usr/local/go/bin

source <(kubectl completion zsh)

# pnpm
export PNPM_HOME="/home/ykhi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.deno/env"

source <(kubectl completion zsh)

export PATH=$HOME/.local/bin:$PATH

eval "$(mise activate zsh)"

# Gemini CLI
export PATH="/home/ykhi/.cache/.bun/bin:$PATH"

# LM Studio CLI
export PATH="/home/ykhi/.lmstudio/bin:$PATH"
