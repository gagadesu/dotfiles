#!/bin/bash

# Create .env
read -p "PSK: " PSK
read -p "PORT: " PORT
read -p "PASSWORD: " PASSWORD

echo "PORT=$PORT" >>.env
echo "PASSWORD=$PASSWORD" >>.env

# Create snell.conf
cat <<EOL >snell.conf
[snell-server]
listen = 0.0.0.0:${PORT}
psk = ${PSK}
ipv6 = false
EOL
