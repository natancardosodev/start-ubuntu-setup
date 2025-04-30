# start-ubuntu-setup

Shell de configuração inicial no Ubuntu 22 para instalação de programas de desenvolvimento e afins.

## Instalação

```sh
sudo apt install gedit curl
cd Downloads
curl -0 https://raw.githubusercontent.com/natancardosodev/start-ubuntu-setup/master/startup.sh >> startup.sh
sudo chmod +x /home/$USER/Downloads/startup.sh
curl -0 https://raw.githubusercontent.com/natancardosodev/start-ubuntu-setup/master/startup2.sh >> startup2.sh
sudo chmod +x /home/$USER/Downloads/startup2.sh
curl -0 https://raw.githubusercontent.com/natancardosodev/start-ubuntu-setup/master/startup3.sh >> startup3.sh
sudo chmod +x /home/$USER/Downloads/startup3.sh
```

## Execução

```sh
/home/$USER/Downloads/startup.sh
/home/$USER/Downloads/startup2.sh
/home/$USER/Downloads/startup3.sh
```

## Programas instalados

-   zsh / autosuggestions / fonts-firacode
-   xclip
-   curl
-   git / SSH Key
-   gedit
-   VS Code / extensions
-   nvm / npm / @angular/cli
-   Apache
-   terminator
-   docker / docker-compose
-   teamviewer
-   Google Chrome
-   brave
-   dbeaver
-   composer
-   sublime text
-   anydesk
-   OBS Studio
