#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

toast() {
    noctalia msg notification-show "$(jo icon=bulb summary="$1" body="$2")"
}

line=$(shuf -n 1 "$SCRIPT_DIR/advice_list.txt")
author=$(echo "$line" | grep -oP ' ~ \K.*')
advice=$(echo "$line" | sed 's/ ~.*//')

echo "$advice" | grep -oP '[^,.!?]+[,.!?]' | while read -r sentence; do
    toast "$author" "$sentence"
    sleep 5
done
