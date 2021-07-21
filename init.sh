#!/bin/bash
sudo apt-get update

echo 'installing curl' 
sudo apt install curl -y

echo 'installing git' 
sudo apt install git -y

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

echo 'installing code'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders
echo 'finished install code' 

echo 'installing extensions'
code --install-extension eamodio.gitlens
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension vscode-icons-team.vscode-icons
echo 'finished install extensions' 

echo 'installing docker' 
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

sudo groupadd docker
sudo usermod -aG docker $USER
docker run hello-world
echo 'finished install docker'

echo 'installing docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
echo 'finished install docker-compose'

echo 'isntall tree'
sudo snap tree
echo 'finished install tree'

echo 'installing SDKMAN'
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
echo sdk version
echo 'finished install SDKMAN'

echo 'installing Java'
sdk list java
sdk install java -y
echo 'finished install Java'

echo 'installing dbeaver'
sudo snap install dbeaver-ce
echo 'finished install dbeaver'

echo 'install intellij'
sudo curl -L "https://download.jetbrains.com/product?code=IIC&latest&distribution=linux" | sudo tar xvz -C /opt/intellij --strip 1 && /opt/intellij/bin/idea.sh
echo 'finished install intellij'