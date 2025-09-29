# golang
export GOROOT="/usr/local/go"
export PATH="$PATH:$GOROOT"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"
export GOPATH="$HOME/go PATH=$PATH:/usr/local/go/bin:$GOPATH/bin"
# pnpm
export PNPM_HOME="/home/ykhi/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"
# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
