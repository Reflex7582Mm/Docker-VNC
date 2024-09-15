#!/bin/bash

sudo pkill provjobd

check() {
    currentTime=$(TZ=Etc/UTC date +"%H-%M")

    targetTimes=("00-00" "05-50" "10-50" "15-50" "20-50")

    for target in "${targetTimes[@]}"; do
        if [[ "$currentTime" != "$target" ]]; then continue; fi

        sudo tailscale up --hostname="old-windows-$RANDOM" --advertise-exit-node --ssh

        GH_TOKEN=$2 gh api \
            --method POST \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            /repos/CeciliaKelley33Mm/Docker-VNC/actions/workflows/makewindows.yml/dispatches \
            -f "ref=main" -f "inputs[version]=win11" -f "inputs[runNext]=true"
    done
}

while true; do
    if [[ "$1" == "true" ]]; then
        check
    fi

    ping -c 1 google.com 
    curl google.com

    sleep 60
done
