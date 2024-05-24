#!/bin/bash
h() {
    echo  ""
    echo  "Usage: ./run.sh <VHOST> <HOSTNAME[:PORT]>"
    echo  ""
    echo  "Example: ./run.sh www.blah.com 10.10.10.10"
    echo  "Example: ./run.sh www.blah.com 10.10.10.10:7087"
    echo  ""
}

main() {
    if [[ "$1" == "" || "$2" == "" ]]; then
        h
        exit 1
    fi
    vhost=$1
    host=$2

    GOBUSTER="./gobuster dir --retry --threads 5 --timeout 15s --status-codes-blacklist '404,400,403' -H 'Host: $vhost' -u http://$host"

    bash -c "$GOBUSTER -w ./wordlists/LFI-Jhaddix.txt -o reports/lfi-fuzzing.txt"
    bash -c "$GOBUSTER -w ./wordlists/LFI-gracefulsecurity-linux.txt -o reports/lfi-linux.txt"
}

main $@
