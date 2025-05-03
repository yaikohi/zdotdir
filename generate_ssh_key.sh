#/bin/sh

KEY_TYPE="ed25519"
COMMENT="erik.beem@hotmail.com"
KEY_FILENAME="$HOME/.ssh/github"

ssh-keygen -t $KEY_TYPE -C $COMMENT -f $KEY_FILENAME
