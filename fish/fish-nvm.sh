NODE_VERSION=$(ls $HOME/.local/share/nvm | tail -n1)

export PATH="$HOME/.local/share/nvm/$NODE_VERSION/bin:$PATH"
