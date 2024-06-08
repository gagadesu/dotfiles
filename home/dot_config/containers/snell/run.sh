#!/bin/bash

# Create .env
read -p "PSK: " PSK
read -p "PORT: " PORT
read -p "PASSWORD: " PASSWORD
echo "PSK=$PSK" >>.env
echo "PORT=$PORT" >>.env
echo "PASSWORD=$PASSWORD" >>.env
