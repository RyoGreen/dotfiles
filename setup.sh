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
brew install neovim skhd koekeishiya/formulae/yabai tmux fzf

# Run fzf install script to enable keybindings and completions
echo "⚙️  Setting up fzf keybindings and completions..."
"$(brew --prefix)/opt/fzf/install"

# Install enhancd
echo "📁 Installing enhancd..."
git clone https://github.com/babarot/enhancd && source enhancd/init.sh

# Add enhancd init to .zshrc if not already present
if ! grep -q 'enhancd/init.sh' ~/.zshrc; then
    echo 'source ~/config/enhancd/init.sh' >> ~/.zshrc
    echo "✅ enhancd added to .zshrc"
else
    echo "⚠️  enhancd already configured in .zshrc"
fi

echo "✅ Software installation complete!"

# Register and start yabai & skhd services
echo "🚀 Starting yabai & skhd services..."
sudo yabai --install-service
brew services start yabai

skhd --install-service
brew services start skhd

echo "✅ Setup completed successfully! 🎉"

