#!/usr/bin/env bash

toast() {
    noctalia-shell ipc call toast send "{\"title\": \"$1\"}"
}

if (( RANDOM % 2 == 0 )); then
    toast "Heads"
else
    toast "Tails"
fi
