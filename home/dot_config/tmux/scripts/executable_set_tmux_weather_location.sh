#!/bin/bash

# fetch city name
city=$(curl -s http://myip.ipip.net | awk '/来自于：中国/{print $5}')

# set city
if [ -n "$city" ]; then
	tmux set-option -g @tmux-weather-location "$city"
fi
