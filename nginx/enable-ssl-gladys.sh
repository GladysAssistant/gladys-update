#!/bin/bash
#
#
# THIS SCRIPT ENABLE HTTPS IN GLADYS
# IT GENERATE SELF SIGNED CERTIFICATE
# SO IT'S NORMAL IF YOUR BROWSER TELL YOU 
# CONNECTION IS NOT SECURE.


echo "Creating SSL Certificate"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt  -subj "/C=FR/ST=IDF/L=Paris/O=Gladys/CN=gladysassistant.com"

echo "Creating strong Diffie-Hellman group"
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

echo "Using new configuration in Nginx"
sudo ln -s /etc/nginx/sites-available/gladys-ssl /etc/nginx/sites-enabled/gladys-ssl
sudo rm /etc/nginx/sites-enabled/gladys

echo "Restarting Nginx"
sudo service nginx restart

echo "HTTPS is now active on Gladys ! Congrats :)"