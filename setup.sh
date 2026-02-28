#!/bin/bash

# Exit on any error, undefined variable, or pipe failure
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
    exit 1
}

info() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] INFO: $1${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to backup existing file
backup_file() {
    local file="$1"
    if [ -e "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        log "Backing up existing $file to $backup"
        cp -r "$file" "$backup"
    fi
}

# Function to validate file exists
validate_file() {
    local file="$1"
    if [ ! -e "$file" ]; then
        error "Required file/directory not found: $file"
    fi
}

# Function to check macOS version
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        error "This script is designed for macOS only. Current OS: $OSTYPE"
    fi
    
    local macos_version=$(sw_vers -productVersion)
    log "macOS version detected: $macos_version"
    
    # Check if macOS version is supported (10.14 or later)
    if [[ $(echo "$macos_version" | cut -d. -f1) -lt 10 ]] || \
       ([[ $(echo "$macos_version" | cut -d. -f1) -eq 10 ]] && \
        [[ $(echo "$macos_version" | cut -d. -f2) -lt 14 ]]); then
        error "macOS 10.14 (Mojave) or later is required. Current version: $macos_version"
    fi
}

# Function to check and install Homebrew
check_homebrew() {
    if ! command_exists brew; then
        error "Homebrew is not installed. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        echo "   Then restart your terminal and run this script again."
    fi
    
    log "Homebrew found at: $(which brew)"
    
    # Update Homebrew
    log "Updating Homebrew..."
    brew update || warn "Failed to update Homebrew, continuing anyway..."
}

# Function to check dotfiles directory
check_dotfiles() {
    DOTFILES_DIR=~/dotfiles
    
    if [ ! -d "$DOTFILES_DIR" ]; then
        error "Dotfiles directory not found at $DOTFILES_DIR"
    fi
    
    log "Dotfiles directory found at: $DOTFILES_DIR"
    
    # Validate required files exist
    local required_files=(
        ".config/nvim"
        ".skhdrc"
        ".yabairc"
        "tmux.conf"
    )
    
    for file in "${required_files[@]}"; do
        validate_file "$DOTFILES_DIR/$file"
    done
    
    log "All required dotfiles found"
}

# Function to create symbolic links
create_symlinks() {
    DOTFILES_DIR=~/dotfiles
    
    local files=(
        ".config/nvim"
        ".skhdrc"
        ".yabairc"
        "tmux.conf"
    )
    
    log "Creating symbolic links..."
    
    for file in "${files[@]}"; do
        local target="$DOTFILES_DIR/$file"
        local link="$HOME/$file"
        
        # Create parent directory if it doesn't exist
        if [[ "$file" == *"/"* ]]; then
            local parent_dir=$(dirname "$link")
            if [ ! -d "$parent_dir" ]; then
                log "Creating directory: $parent_dir"
                mkdir -p "$parent_dir"
            fi
        fi
        
        # Backup existing file/directory
        backup_file "$link"
        
        # Remove existing file/directory if it exists
        if [ -e "$link" ]; then
            log "Removing existing: $link"
            rm -rf "$link"
        fi
        
        # Create symbolic link
        if ln -sf "$target" "$link"; then
            log "✅ Linked $file"
        else
            error "Failed to create symbolic link for $file"
        fi
        
        # Verify the link was created correctly
        if [ ! -L "$link" ] || [ ! -e "$link" ]; then
            error "Symbolic link verification failed for $file"
        fi
    done
    
    log "All symbolic links created successfully"
}

# Function to install software
install_software() {
    log "Installing required software..."

    local packages=(
        "neovim"
        "skhd"
        "tmux"
        "fzf"
        "ripgrep"
        "fd"
        "git"
    )

    local to_install=()

    for package in "${packages[@]}"; do
        if ! brew list "$package" >/dev/null 2>&1; then
            to_install+=("$package")
        else
            log "✅ $package already installed"
        fi
    done

    # yabai
    if ! brew list yabai >/dev/null 2>&1; then
        brew tap koekeishiya/formulae || error "Failed to add yabai tap"
        to_install+=("yabai")
    fi

    if [ ${#to_install[@]} -gt 0 ]; then
        brew install "${to_install[@]}" || error "Failed to install packages"
    fi

    # Nerd Font
    brew tap homebrew/cask-fonts 2>/dev/null || true
    if ! brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1; then
        brew install --cask font-jetbrains-mono-nerd-font
        log "✅ JetBrainsMono Nerd Font installed"
    fi

    log "Software installation completed"
}

# Install LSP language servers for better code navigation
log "Installing LSP language servers..."

# Install gopls for Go
if ! command -v gopls &> /dev/null; then
    log "Installing gopls..."
    go install golang.org/x/tools/gopls@latest
    log "✅ gopls installed"
else
    log "✅ gopls already installed"
fi

# Install TypeScript language server
if ! command -v typescript-language-server &> /dev/null; then
    log "Installing TypeScript language server..."
    npm install -g typescript typescript-language-server
    log "✅ TypeScript language server installed"
else
    log "✅ TypeScript language server already installed"
fi

# Install Rust analyzer (if Rust is installed)
if command -v rustc &> /dev/null; then
    if ! command -v rust-analyzer &> /dev/null; then
        log "Installing rust-analyzer..."
        rustup component add rust-analyzer
        log "✅ rust-analyzer installed"
    else
        log "✅ rust-analyzer already installed"
    fi
fi

# Function to setup fzf
setup_fzf() {
    log "Setting up fzf keybindings and completions..."
    
    local fzf_install_script="$(brew --prefix)/opt/fzf/install"
    if [ -f "$fzf_install_script" ]; then
        if "$fzf_install_script" --all; then
            log "✅ fzf setup completed"
        else
            warn "fzf setup failed, but continuing..."
        fi
    else
        error "fzf install script not found"
    fi
}

# Function to setup services
setup_services() {
    log "Setting up yabai and skhd services..."
    
    # Setup yabai
    if ! brew services list | grep -q "yabai.*started"; then
        log "Installing yabai service..."
        if sudo yabai --install-service; then
            if brew services start yabai; then
                log "✅ yabai service started"
            else
                warn "Failed to start yabai service"
            fi
        else
            warn "Failed to install yabai service"
        fi
    else
        log "⚠️  yabai service already running"
    fi
    
    # Setup skhd
    if ! brew services list | grep -q "skhd.*started"; then
        log "Installing skhd service..."
        if skhd --install-service; then
            if brew services start skhd; then
                log "✅ skhd service started"
            else
                warn "Failed to start skhd service"
            fi
        else
            warn "Failed to install skhd service"
        fi
    else
        log "⚠️  skhd service already running"
    fi
}

# Function to verify installation
verify_installation() {
    log "Verifying installation..."
    
    local success=true
    
    # Check symbolic links
    local files=(".config/nvim" ".skhdrc" ".yabairc" "tmux.conf")
    for file in "${files[@]}"; do
        if [ ! -L "$HOME/$file" ] || [ ! -e "$HOME/$file" ]; then
            error "Symbolic link verification failed: $file"
            success=false
        fi
    done
    
    # Check software installation
    local packages=("neovim" "skhd" "yabai" "tmux" "fzf" "zoxide" "starship")
    for package in "${packages[@]}"; do
        if ! command_exists "$package"; then
            warn "Package not found in PATH: $package"
            success=false
        fi
    done
    
    # Check enhancd
    if [ ! -d "$HOME/enhancd" ]; then
        warn "enhancd directory not found"
        success=false
    fi
    
    if [ "$success" = true ]; then
        log "✅ All verifications passed"
    else
        warn "Some verifications failed, but installation may still be functional"
    fi
}

# Main execution
main() {
    log "Starting dotfiles setup..."
    
    check_macos
    check_homebrew
    check_dotfiles
    create_symlinks
    install_software
    setup_fzf
    install_enhancd
    setup_services
    verify_installation
    
    echo ""
    log "🎉 Setup completed successfully!"
    echo ""
    info "Next steps:"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. Grant accessibility permissions to yabai and skhd:"
    echo "   System Preferences > Security & Privacy > Privacy > Accessibility"
    echo "3. You may need to restart your computer for all services to work properly"
    echo ""
    info "If you encounter any issues, check the backup files created during installation"
}

# Run main function
main "$@"


