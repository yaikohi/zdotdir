#!/bin/bash

# --- Embargo: Fast codebase dependency extraction optimized for AI code analysis.

echo "Cloning Embargo repository..."
git clone https://github.com/lrnzgiusti/embargo.git $HOME/embargo
cd $HOME/embargo

echo "Building Embargo from source..."
cargo build --release

echo "Globally installing Embargo..."
# Install globally (optional)
cargo install --path .

echo "Embargo installation complete!"
echo "Embargo is now available globally."
