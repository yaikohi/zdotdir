#/bin/sh
 sudo apt install bat
# because 'bat' was taken by some other binary, need to link it to batcat which is what was installed by the above sudo apt install command.
# see: https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

