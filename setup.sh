#!/bin/bash

DOTFILES_DIR=~/dotfiles
FILES=(
    ".config/nvim"
    ".skhdrc"
    ".yabairc"
    "tmux.conf"
)

# Create symbolic links
for file in "${FILES[@]}"; do
    ln -sf "$DOTFILES_DIR/$file" ~/$file
    echo "🔗 Linked $file"
done

echo "✅ Dotfiles linked!"

# Install required software (macOS)
echo "📦 Installing required software..."
brew install neovim skhd koekeishiya/formulae/yabai tmux

echo "✅ Software installation complete!"

# Register and start yabai & skhd services
echo "🚀 Starting yabai & skhd services..."
sudo yabai --install-service
brew services start yabai

skhd --install-service
brew services start skhd

echo "✅ Setup completed successfully! 🎉"

