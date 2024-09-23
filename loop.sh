#!/bin/bash

GH_TOKEN=$2

REPO=$3
WORKFLOW_FILE=$4
BRANCH=$5

NAME=$6

firstTime=1

alreadyDone=0

sudo pkill provjobd

check() {
    currentTime=$(TZ=Etc/UTC date +"%H-%M")

    # this is the pattern. the old machine will activate the new machine 1 hour before it terminates

    # 1 00:00 RUN
    # 1 05:50 ACTIVATE 2
    # 1 06:00 TERMINATE

    # 2 05:50 RUN
    # 2 10:50 ACTIVATE 3
    # 2 11:50 TERMINATE

    # 3 10:50 RUN
    # 3 15:50 ACTIVATE 4
    # 3 16:50 TERMINATE

    # 4 15:50 RUN
    # 4 20:50 ACTIVATE 5
    # 4 21:50 TERMINATE

    # 5 20:50 RUN
    # 5 00:00 ACTIVATE 1
    # 5 01:50 TERMINATE

    targetTimes=("00-00" "05-50" "10-50" "15-50" "20-50")

    for target in "${targetTimes[@]}"; do
        if [[ "$currentTime" != "$target" ]]; then continue; fi

        alreadyDone=1

        sudo tailscale up --hostname="old-$NAME-$RANDOM" --advertise-exit-node --ssh

        gh api \
            --method POST \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            "/repos/CeciliaKelley33Mm/$REPO/actions/workflows/$WORKFLOW_FILE/dispatches" \
            -f "ref=$BRANCH" -f "inputs[runNext]=true"
    done
}

while true; do
    if [ "$firstTime" != 1 ] && [ "$alreadyDone" != 1 ] && [ "$1" == "true" ]; then
        check
    fi

    sudo sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches

    ping -c 1 google.com 
    curl google.com

    if [ "$firstTime" != 1 ]; then
        sleep 10
    else
        sleep 120

        firstTime=0
    fi
done
