#!/usr/bin/env bash
BACKUP_FILE="/home/dominictdavies/Backups/world-ours/world-ours_$(date +%Y-%m-%d).tar.gz"

systemctl stop neoforge-server
tar -czf "$BACKUP_FILE" -C /home/dominictdavies/NeoForge world-ours/
chown dominictdavies:users "$BACKUP_FILE"
systemctl reboot
