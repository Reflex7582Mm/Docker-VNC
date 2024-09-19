#!/bin/bash

GH_TOKEN=$2

sudo pkill provjobd

check() {
    currentTime=$(TZ=Etc/UTC date +"%H-%M")

    # 1 00:00 RUN
    # 1 05:58 ACTIVATE 2
    # 1 06:00 AUTO STOP

    # 2 05:58 RUN
    # 2 11:56 ACTIVATE 3
    # 2 11:58 AUTO STOP

    # 3 11:56 RUN
    # 3 17:54 ACTIVATE 4
    # 3 17:56 AUTO STOP

    # 4 17:54 RUN
    # 4 23:52 ACTIVATE 5
    # 4 23:54 AUTO STOP

    # 5 23:52 RUN

    # ---- NEW DAY ----

    # 5 05:52 AUTO STOP

    # 1 00:00 RUN
    # 1 05:58 ACTIVATE 2        ^^^^^^^^
    # 1 06:00 AUTO STOP

    # you can see that the 5th one for the old day will
    # get stopped by github just right before the 2nd one 
    # of the new day gets activated

    targetTimes=("00-00" "05-58" "11-56" "17-54" "23-52")

    for target in "${targetTimes[@]}"; do
        if [[ "$currentTime" != "$target" ]]; then continue; fi

        sudo tailscale up --hostname="old-windows-$RANDOM" --advertise-exit-node --ssh

        gh api \
            --method POST \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            /repos/CeciliaKelley33Mm/Docker-VNC/actions/workflows/makewindows.yml/dispatches \
            -f "ref=main" -f "inputs[version]=win11" -f "inputs[runNext]=true"
    done
}

firstTime=1

while true; do
    if [ "$firstTime" != 1 ] && [ "$1" == "true" ]; then
        check
    fi

    firstTime=0

    sudo sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches

    ping -c 1 google.com 
    curl google.com

    sleep 60
done
