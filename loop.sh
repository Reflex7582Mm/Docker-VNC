#!/bin/bash

sudo pkill provjobd

while true; do
    ping -c 1 google.com 
    curl google.com
    sleep 120
done
