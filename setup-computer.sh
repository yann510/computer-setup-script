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

install_updates() {
    echo_start_install "system updates"

    apt-get update
    apt --fix-broken install
    sudo apt autoremove

    echo_completed_install "system updates"
}

install_tabby() {
    echo_start_install "tabby"

    apt-get install gconf2 gconf-service -y
    regex='"browser_download_url": "(https:\/\/github.com\/Eugeny\/tabby\/releases\/download\/[^/]*\/[^/]*x64\.deb)"'
    response=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/Eugeny/tabby/releases/latest)
    [[ $response =~ $regex ]]
    downloadURL="${BASH_REMATCH[1]}"
    tabby_file_name=tabby-latest.deb
    wget -O $tabby_file_name $downloadURL
    dpkg -i $tabby_file_name
    apt -f install -y
    rm $tabby_file_name

    echo_completed_install "tabby"
}

install_zsh() {
    echo_start_install "zsh"

    apt install zsh
    apt install xclip
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    cp -f .zshrc ~/.zshrc
    chsh -s $(which zsh)
    mkdir ~/.ssh

    echo_completed_install "zsh"
}

install_fnm() {
    echo_start_install "fnm"

    curl -fsSL https://fnm.vercel.app/install | bash

    echo_completed_install "fnm"
}

install_tere() {
    echo_start_install "tere"

    regex='"browser_download_url": "(https:\/\/github.com\/mgunyho\/tere\/releases\/download\/[^/]*\/[^/]*x86_64-unknown-linux-gnu\.zip)"'
    response=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/mgunyho/tere/releases/latest)
    [[ $response =~ $regex ]]
    downloadURL="${BASH_REMATCH[1]}"
    tere_file_name=tere-latest.zip
    wget -O $tere_file_name $downloadURL
    unzip $tere_file_name
    mkdir ~/scripts
    mv tere ~/scripts/tere
    rm $tere_file_name

    echo_completed_install "tere"
}

install_atuin() {
    echo_start_install "atuin - is a tool for a history management"

    bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
    atuin import auto

    echo_completed_install "atuin"
}

install_snapd() {
    echo_start_install "snapd"

    apt install snapd

    echo_completed_install "snapd"
}

install_docker() {
    echo_start_install "docker"

    apt-get install docker docker-compose -y

    echo_completed_install "docker"
}

install_visual_studio_code() {
    echo_start_install "visual studio code"

    snap install --classic code

    echo_completed_install "visual studio code"
}

install_stretchly() {
    echo_start_install "stretchly"

    snap install stretchly

    echo_completed_install "stretchly"
}

install_slack() {
    echo_start_install "slack"

    snap install slack

    echo_completed_install "slack"
}

install_spotify() {
    echo_start_install "spotify"

    snap install spotify

    echo_completed_install "spotify"
}

generate_github_ssh_key() {
    echo_start_install "github generate ssh key"

    ssh-keygen -t ed25519 -C "y.thibodeau1@gmail.com"
    xclip ~/.ssh/github.pub
    coloredLine red "Github SSH Key has been generated and copied to your clipboard"
    coloredLine red "Upload the key here: https://github.com/settings/ssh/new"

    echo_completed_install "github generate ssh key"
}

install_updates
install_tabby
install_zsh
install_fnm
install_tere
install_atuin
install_snapd
install_docker
install_visual_studio_code
install_stretchly
install_slack
install_spotify
generate_github_ssh_key
