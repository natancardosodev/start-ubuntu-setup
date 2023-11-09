#!/usr/bin/env bash

echo "Instalando sublime text"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg >/dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

echo "Instalando anydesk"
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" >/etc/apt/sources.list.d/anydesk-stable.list

echo "Instalando OBS Studio"
sudo add-apt-repository ppa:obsproject/obs-studio

sudo apt-get update

sudo apt install obs-studio
sudo apt-get install sublime-text
sudo apt-get install anydesk
sudo apt-get install apt-transport-https

echo 'installing tool to handle clipboard via CLI'
sudo apt-get install xclip -y

export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.zshrc

echo 'installing curl'
sudo apt install curl -y

echo 'installing git'
sudo apt install git -y

echo "What name do you want to use in GIT user.name?"
echo "For example, mine will be \"Natan\""
read git_config_user_name
git config --global user.name "$git_config_user_name"
clear

echo "What email do you want to use in GIT user.email?"
echo "For example, mine will be \"natan@gmail.com\""
read git_config_user_email
git config --global user.email $git_config_user_email
clear

echo "Can I set VIM as your default GIT editor for you? (y/n)"
read git_core_editor_to_vim
if echo "$git_core_editor_to_vim" | grep -iq "^y"; then
  git config --global core.editor vim
else
  echo "Okay, no problem. :) Let's move on!"
fi

echo "Generating a SSH Key"
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
ssh-add ~/.ssh/id_rsa
eval "$(ssh-agent -s)"
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo 'installing nvm'
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash)"

export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zshrc
nvm --version
nvm install 14
nvm alias default 14
node --version
npm --version

echo 'installing @angular/cli'
npm i -g @angular/cli@12

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
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >>~/.zshrc  # This loads nvm
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >>~/.zshrc  # This loads nvm bash_completion
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >>~/.zshrc  # This loads nvm bash_completion

source ~/.zshrc

echo "Instalando theme"
sudo apt install fonts-firacode -y
wget -O ~/.oh-my-zsh/themes/node.zsh-theme https://raw.githubusercontent.com/skuridin/oh-my-zsh-node-theme/master/node.zsh-theme
sed -i 's/.*ZSH_THEME=.*/ZSH_THEME="node"/g' ~/.zshrc

echo 'enabling workspaces for both screens'
gsettings set org.gnome.mutter workspaces-only-on-primary false

echo 'installing gedit'
sudo apt install gedit -y
clear

echo 'installing brave'
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

echo 'installing code'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders
sudo apt install brave-browser

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

echo 'installing spotify'
snap install spotify

echo 'installing chrome'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo 'installing flameshot'
apt install flameshot

echo 'installing terminator'
sudo apt-get update
sudo apt-get install terminator -y

echo 'adding dracula theme'
cat <<EOF >~/.config/terminator/config
[global_config]
  title_transmit_bg_color = "#ad7fa8"
[keybindings]
  close_term = <Primary>w
  close_window = <Primary>q
  new_tab = <Primary>t
  new_window = <Primary>i
  paste = <Primary>v
  split_horiz = <Primary>e
  split_vert = <Primary>d
  switch_to_tab_1 = <Primary>1
  switch_to_tab_10 = <Primary>0
  switch_to_tab_2 = <Primary>2
  switch_to_tab_3 = <Primary>3
  switch_to_tab_4 = <Primary>4
  switch_to_tab_5 = <Primary>5
  switch_to_tab_6 = <Primary>6
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
[plugins]
[profiles]
  [[default]]
    cursor_color = "#aaaaaa"
EOF

cat <<EOF >>~/.config/terminator/config
[[Dracula]]
    background_color = "#1e1f29"
    background_darkness = 0.88
    background_type = transparent
    copy_on_selection = True
    cursor_color = "#bbbbbb"
    foreground_color = "#f8f8f2"
    palette = "#000000:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#bbbbbb:#555555:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#ffffff"
    scrollback_infinite = True
EOF

echo 'installing docker'
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

chmod 777 /var/run/docker.sock
docker run hello-world

echo 'installing docker-compose'
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo 'installing aws-cli'
sudo apt-get install awscli -y
aws --version
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
session-manager-plugin --version

echo 'installing teamviewer'
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install -y ./teamviewer_amd64.deb

echo 'installing dbeaver'
wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
sudo apt-get install -f

echo "Instalando composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=1.10.19
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
