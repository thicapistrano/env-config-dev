##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
red='\e[31m'
clear='\e[0m'
##
# Color Functions
##
ColorGreen(){
    echo $green$1$clear
}
ColorBlue(){
    echo $blue$1$clear
}
ColorRed(){
    echo $red$1$clear
}

##
# Menu
##
mainmenu() {
    echo "Menu
$(ColorGreen '1)') Install
$(ColorGreen '2)') Config
$(ColorGreen '0)') Exit
    $(ColorBlue 'Choose an option:') "
    read option
    case $option in
        1) install_menu ;;
        2) config_menu ;;
        0) bye ;;
        *) menu_error ;;
    esac
}

install_menu() {
    echo "Menu Install
$(ColorGreen '1)') AWS CLI
$(ColorGreen '2)') Docker and Docker-compose
$(ColorGreen '3)') VSCode
$(ColorGreen '4)') Git and Github Cli
$(ColorGreen '5)') Tree
$(ColorGreen '6)') Ngrok
$(ColorGreen '0)') Back
    $(ColorBlue 'Choose an option:') "
    read option
    case $option in
        1) install_aws_cli ;;
        2) install_docker ;;
        3) install_git ;;
        4) install_vscode ;;
        5) install_tree ;;
        6) install_ngrok ;;
        0) mainmenu ;;
        *) menu_error ;;
    esac
}

config_menu() {
    echo "Configuração
$(ColorGreen '1)') Git
$(ColorGreen '0)') Back
    $(ColorBlue 'Choose an option:') "
    read option
    case $option in
        1) config_git ;;
        0) mainmenu ;;
        *) menu_error ;;
    esac
}

bye() {
    echo "Bye"
    exit 0
}

menu_error() {
    echo "$(ColorRed 'Wrong option')"
    mainmenu
}

update(){
    sudo apt-get update
    sudo apt-get upgrade
}

install_aws_cli() {
    command=`which aws`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'AWS CLI not found, installing...')"
        update
        cd /tmp \
        && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
        && unzip awscliv2.zip \
        && sudo ./aws/install \
        && rm -rf aws awscliv2.zip
        echo "$(ColorBlue 'AWS CLI finished install')"
    else
        echo "$(ColorBlue 'AWS CLI already installed')"
    fi
    mainmenu
}

install_docker() {
    command=`which docker`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'Docker installing')"
        update
        sudo apt-get remove docker docker-engine docker.io
        sudo apt install docker.io -y
        sudo systemctl start docker
        sudo systemctl enable docker
        docker --version
        
        sudo groupadd docker
        sudo usermod -aG docker $USER
        docker run hello-world
        
        echo "$(ColorBlue 'Docker finished install')"
    else
        echo "$(ColorBlue 'Docker already installed')"
    fi
    install_docker_compose
    mainmenu
}

install_docker_compose() {
    command=`which docker-compose`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'Docker-compose installing')"
        update
        sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        docker-compose --version
        echo "$(ColorBlue 'Docker finished install')"
    else
        echo "$(ColorBlue 'Docker already installed')"
    fi
    mainmenu
}


install_git(){
    command=`which git`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'Docker-compose installing')"
        sudo apt install git -y
        echo "$(ColorBlue 'Docker finished install')"
    else
        echo "$(ColorBlue 'Docker already installed')"
    fi
    
    install_github_cli
    
    mainmenu
    
}

install_github_cli(){
    command=`which docker-compose`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'Docker-compose installing')"
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh -y
        gh --version
        echo "$(ColorBlue 'Docker finished install')"
    else
        echo "$(ColorBlue 'Docker already installed')"
    fi
    mainmenu
    
}

install_vscode(){
    command=`which code`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'Docker-compose installing')"
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo apt-get install apt-transport-https -y
        sudo apt-get update
        sudo apt-get install code -y # or code-insiders
        code --install-extension eamodio.gitlens
        # code --install-extension ms-azuretools.vscode-docker
        # code --install-extension ms-python.vscode-pylance
        # code --install-extension vscode-icons-team.vscode-icons
        echo "$(ColorBlue 'Docker finished install')"
    else
        echo "$(ColorBlue 'Docker already installed')"
    fi
    mainmenu
    
}

install_tree(){
    command=`which tree`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'Tree installing')"
        sudo snap tree \
        && tree --version
        echo "$(ColorBlue 'Docker finished install')"
    else
        echo "$(ColorBlue 'Docker already installed')"
    fi
    mainmenu
    
}

install_ngrok(){
    command=`which ngrok`
    if [ ! -f "$command" ]; then
        echo "$(ColorBlue 'Ngrok installing')"
        curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
        && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list \
        && sudo apt update && sudo apt install ngrok \
        && ngrok --version
        echo "$(ColorBlue 'Ngrok finished install')"
    else
        echo "$(ColorBlue 'Ngrok already installed')"
    fi
    mainmenu
    
}


config_git(){
    echo "What name do you want to use in GIT user.name?"
    read git_config_user_name
    git config --global user.name "$git_config_user_name"
    clear
    
    echo "What email do you want to use in GIT user.email?"
    read git_config_user_email
    git config --global user.email $git_config_user_email
    clear
    
    echo 'installing tool to handle clipboard via CLI'
    sudo apt-get install xclip -y
    export alias pbcopy='xclip -selection clipboard'
    export alias pbpaste='xclip -selection clipboard -o'
    source ~/.zshrc
    echo 'finished install xclip'
    
    echo "Generating a SSH Key"
    ssh-keygen -t rsa -b 4096 -C $git_config_user_email
    ssh-add ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
    echo 'finished generate SSH Key'
    
}


install_zsh(){
    
    
    echo 'install zsh'
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    zsh --version
    echo 'finished install zsh'
    
    echo 'install zinit'
    sh -c "$(curl -fsSL https://git.io/zinit-install)"
    zinit --version
    echo 'finished install zinit'
    
    echo 'configure zinit'
    echo ~/.zshrc >> "zinit light zsh-users/zsh-autosuggestions"
    echo ~/.zshrc >> "zinit light zdharma-continuum/fast-syntax-highlighting"
    echo 'finished configuration zinit'
}
mainmenu