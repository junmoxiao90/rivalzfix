#!/bin/bash

# Запросить у пользователя ввод имени пользователя и пароля
read -p "Введите имя пользователя: " USER
read -s -p "Введите пароль: " PASSWORD
echo # Добавляем перенос строки после ввода пароля

# Обновить список пакетов
sudo apt update

# Установить GNOME Desktop
sudo apt install -y task-gnome-desktop     

# Установить сервер удаленного рабочего стола (xrdp) 
sudo apt install -y xrdp

# Добавить пользователя с введенным именем и паролем
sudo useradd -m -s /bin/bash $USER
echo "$USER:$PASSWORD" | sudo chpasswd 

# Добавить пользователя в группу sudo для административных прав 
sudo usermod -aG sudo $USER

# Настроить xrdp для использования GNOME desktop
echo "gnome-session" > ~/.xsession

# Перезапустить службу xrdp
sudo systemctl restart xrdp

# Включить xrdp при старте системы
sudo systemctl enable xrdp

sudo systemctl set-default graphical

# Установить необходимые зависимости для Rivalz.ai rClient
sudo apt install -y wget

# Скачать Rivalz.ai rClient AppImage
wget https://api.rivalz.ai/fragmentz/clients/rClient-latest.AppImage -O rClient-latest.AppImage  

# Сделать AppImage исполняемым
chmod +x rClient-latest.AppImage

# Создать каталог Documents, если он не существует
sudo -u $USER mkdir -p /home/$USER/Documents

# Переместить AppImage в каталог Documents пользователя
sudo mv rClient-latest.AppImage /home/$USER/Documents/rClient-latest.AppImage

# Изменить владельца файла rClient на указанного пользователя
sudo chown $USER:$USER /home/$USER/Documents/rClient-latest.AppImage 

echo "Установка завершена. GNOME Desktop, xrdp и Rivalz.ai rClient установлены. Вы можете подключиться через удаленный рабочий стол с пользователем $USER."
