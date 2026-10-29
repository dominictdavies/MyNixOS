#!/usr/bin/env bash

kitty --hold llama-server \
    --model $HOME/Models/AI/Swift-1.5-Qwen3.8-27B-GSQ-RCO-IQ3_XXS-mtp.gguf \
    --n-gpu-layers 99 \
    --ctx-size 65536 \
    --cache-type-k q8_0 \
    --cache-type-v q8_0 \
    --flash-attn on \
    --temperature 1.0 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.0 \
    --presence-penalty 0.0 \
    --repeat-penalty 1.0 \
    --no-reasoning-preserve \
    --spec-type draft-mtp \
    --spec-draft-n-max 1 \
    --host localhost \
    --port 9931 \
    --cors-origins localhost
