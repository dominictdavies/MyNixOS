#!/usr/bin/env bash

toast() {
    noctalia msg notification-show $1
}

if (( RANDOM % 100 == 0)); then
    toast "Side"
else
    if (( RANDOM % 2 == 0 )); then
        toast "Heads"
    else
        toast "Tails"
    fi
fi
