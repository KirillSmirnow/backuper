#!/usr/bin/env sh

CONFIG_DIR="/config"
SCRIPTS_DIR="/scripts"
BACKUP_DIR="/backup"
CRON_FILE="/etc/crontabs/root"

mkdir -p "$CONFIG_DIR"
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$BACKUP_DIR"
: > "$CRON_FILE"

for config_path in "$CONFIG_DIR"/*; do
  name="$(basename "$config_path")"
  script_path="$SCRIPTS_DIR/$name.sh"
  log_path="/root/$name.log"
  echo "Installing backuper '$name'"

  (
    . "$config_path"
    eval "echo \"$(cat backup.sh)\"" > "$script_path"
    chmod +x "$script_path"
    touch "$log_path"
    echo "$when $script_path >> $log_path 2>&1" >> "$CRON_FILE"
  )
done

echo "Starting backuper"
