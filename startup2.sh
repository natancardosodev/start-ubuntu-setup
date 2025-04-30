#!/usr/bin/env bash

echo "Instalando zsh"
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh
source ~/.zshrc

echo "Instalando autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.zshrc
echo "export alias pbcopy='xclip -selection clipboard'" >>~/.zshrc
echo "export alias pbpaste='xclip -selection clipboard -o'" >>~/.zshrc
echo "alias zshrc='sudo gedit ~/.zshrc'" >>~/.zshrc
echo "alias master='git reset --hard && git checkout master && git pull upstream master && git push origin HEAD'" >>~/.zshrc
echo "alias duWww='du -hd 1 /www/'" >>~/.zshrc
echo " " >>~/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >>~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >>~/.zshrc                   # This loads nvm
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >>~/.zshrc # This loads nvm bash_completion
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >>~/.zshrc # This loads nvm bash_completion

source ~/.zshrc

echo "Instalando theme"
sudo apt install fonts-firacode -y
wget -O ~/.oh-my-zsh/themes/node.zsh-theme https://raw.githubusercontent.com/skuridin/oh-my-zsh-node-theme/master/node.zsh-theme
sed -i 's/.*ZSH_THEME=.*/ZSH_THEME="node"/g' ~/.zshrc

echo 'enabling workspaces for both screens'
gsettings set org.gnome.mutter workspaces-only-on-primary false

echo 'installing code'
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
sudo apt update
sudo apt install code

echo 'installing extensions'
code --install-extension Angular.ng-template
code --install-extension christian-kohler.path-intellisense
code --install-extension dbaeumer.vscode-eslint
code --install-extension DEVSENSE.composer-php-vscode
code --install-extension pmneo.tsimporter
code --install-extension DEVSENSE.intelli-php-vscode
code --install-extension donjayamanne.githistory
code --install-extension dracula-theme.theme-dracula
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-close-tag
code --install-extension MS-CEINTL.vscode-language-pack-pt-BR
code --install-extension pflannery.vscode-versionlens
code --install-extension ritwickdey.LiveServer
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension stylelint.vscode-stylelint
code --install-extension tomoki1207.pdf
code --install-extension usernamehw.errorlens
code --install-extension vismalietuva.vscode-angular-support
code --install-extension vscode-icons-team.vscode-icons
code --install-extension waderyan.gitblame
code --install-extension WakaTime.vscode-wakatime
code --install-extension WallabyJs.quokka-vscode
code --install-extension yzhang.markdown-all-in-one

echo 'definindo configurações locais do VS Code'
cp settings.json /home/$USER/.config/Code/User

echo 'installing chrome'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo 'installing docker'
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update
sudo apt install docker-ce
docker --version

sudo usermod -aG docker ${USER}
su - ${USER}

echo 'installing docker-compose'
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
docker-compose --version

echo 'installing dbeaver'
wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
sudo apt-get install -f

echo "Instalando composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo chown -R $userPc:$userPc /home/$userPc/.composer/cache
sudo php -r "unlink('composer-setup.php');"

echo "Instalando Apache"
sudo apt install apache2

# sudo apt install php7.4-fpm
# sudo a2enmod proxy_fcgi setenvif
# sudo a2enconf php7.4-fpm
# sudo a2dismod php7.4
sudo systemctl restart apache2

# sudo service php7.4-fpm restart
sudo a2enmod http2

sudo echo "<IfModule http2_module>" >/etc/apache2/conf-available/http2.conf
sudo echo "Protocols h2 h2c http/1.1" >>/etc/apache2/conf-available/http2.conf
sudo echo "H2Direct on" >>/etc/apache2/conf-available/http2.conf
sudo echo "</IfModule>" >>/etc/apache2/conf-available/http2.conf
sudo echo "ServerName 127.0.0.1" >>/etc/apache2/apache2.conf
sudo a2enconf http2

sudo apachectl configtest && sudo service apache2 restart

echo 'Aumentando o watch do Ubuntu'
sudo sysctl fs.inotify.max_user_instances=8192
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl -p
