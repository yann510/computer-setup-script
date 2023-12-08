#!/bin/bash

set -e

coloredLine() {
    COLOR=""
    case $1 in
    "GREEN" | "green")
        COLOR=$(tput setaf 2)
        ;;
    "RED" | "red")
        COLOR=$(tput setaf 1)
        ;;
    "YELLOW" | "yellow")
        COLOR=$(tput setaf 3)
        ;;
    "BLUE" | "blue")
        COLOR=$(tput setaf 4)
        ;;
    "MAGENTA" | "magenta")
        COLOR=$(tput setaf 5)
        ;;
    "CYAN" | "cyan")
        COLOR=$(tput setaf 6)
        ;;
    *)
        # no color
        COLOR=$(tput sgr0)
        ;;
    esac

    echo "${COLOR}${2}$(tput sgr0)"
}

echo_start_install() {
    coloredLine cyan "------------------------------------------------------------"
    coloredLine green "Installing ${1}"
    coloredLine cyan "------------------------------------------------------------"
    echo ""
}

echo_completed_install() {
    echo ""
    coloredLine magenta "------------------------------------------------------------"
    coloredLine green "Completed ${1} installation"
    coloredLine magenta "------------------------------------------------------------"
    echo ""
}

install_homebrew() {
    echo_start_install "homebrew"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/yann510/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew update

    echo_completed_install "homebrew"
}

install_tabby() {
    echo_start_install "tabby"
    
    brew install --cask tabby

    echo_completed_install "tabby"
}

install_zsh() {
    echo_start_install "zsh"

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    cp .zshrc ~/.zshrc
    chsh -s $(which zsh)
    mkdir ~/.ssh

    echo_completed_install "zsh"
}

install_fnm() {
    echo_start_install "fnm"

    brew install fnm

    echo_completed_install "fnm"
}

install_tere() {
    echo_start_install "tere"

    brew install tere

    echo_completed_install "tere"
}

install_atuin() {
    echo_start_install "atuin - is a tool for a history management"

    brew install atuin
    atuin import auto
    atuin sync

    echo_completed_install "atuin"
}

install_docker() {
    echo_start_install "docker"

    brew install --cask docker

    echo_completed_install "docker"
}

install_visual_studio_code() {
    echo_start_install "visual studio code"

    brew install --cask visual-studio-code

    echo_completed_install "visual studio code"
}

install_stretchly() {
    echo_start_install "stretchly"

    brew install --cask stretchly

    echo_completed_install "stretchly"
}

install_spotify() {
    echo_start_install "spotify"

    brew install --cask spotify

    echo_completed_install "spotify"
}

install_rectangle() {
    echo_start_install "rectangle"

    brew install --cask rectangle
  
    echo_completed_install "rectangle"
}

generate_github_ssh_key() {
    echo_start_install "github generate ssh key"

    cd ~/.ssh && ssh-keygen -t ed25519 -C "y.thibodeau1@gmail.com"
    cat github.pub | pbcopy
    coloredLine red "Github SSH Key has been generated and copied to your clipboard"
    coloredLine red "Upload the key here: https://github.com/settings/ssh/new"

    echo_completed_install "github generate ssh key"
}

install_homebrew
install_tabby
install_fnm
install_tere
install_atuin
install_docker
install_visual_studio_code
install_stretchly
install_spotify
install_rectangle
generate_github_ssh_key
