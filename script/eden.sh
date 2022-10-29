echo 'nameserver 192.199.3.2' > /etc/resolv.conf

apt update
apt install  apache2 -y
apt install  lynx -y
apt install  php -y
apt install wget -y
apt install unzip
apt-get install libapache2-mod-php7.0 -y

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1S0$

unzip /var/www/wise.zip -d /var/www
mv /var/www/wise /var/www/wise.E14.com
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wise.E14.com.conf

echo '<VirtualHost *:80>
        ServerName wise.E14.com
        ServerAlias www.wise.E14.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.E14.com
        Alias "/home" "/var/www/wise.E14.com/index.php/home"

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost> ' > /etc/apache2/sites-available/wise.E14.com.conf

a2ensite wise.E14.com

service apache2 reload
service apache2 restart