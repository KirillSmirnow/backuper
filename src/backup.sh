#!/usr/bin/env sh

log() {
  message=\"\$1\"
  echo \"\$(date) -- \$message\"
}

log '###'
DIR='$BACKUP_DIR/$name'
mkdir -p \"\$DIR\"

log 'Executing pre command'
ssh -o StrictHostKeyChecking=no -p "${remote_port:-22}" "$remote" "$pre_command" || exit 1

log 'Copying file'
target_file=\"\$DIR/\$(date -u \"+%F_%H-%M-%S.bkp\")\"
scp -P "${remote_port:-22}" "$remote:$source" \"\$target_file\" || exit 1
log \"Backup created: \$target_file\"

total_files=\"\$(ls -1 \"\$DIR\"/*.bkp | wc -l)\"
let old_files=\$total_files-$max_files
if [[ \$old_files -gt 0 ]]; then
  log \"Removing \$old_files/\$total_files old backups\"
  ls -1 \"\$DIR\"/*.bkp | head -n \"\$old_files\" | xargs rm
fi

total_files=\"\$(ls -1 \"\$DIR\"/*.bkp | wc -l)\"
log \"Now there are \$total_files backups\"
