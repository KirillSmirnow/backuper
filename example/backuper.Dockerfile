FROM backuper
COPY --chmod=400 keys/id_backuper .ssh/id_ed25519
COPY config /config
