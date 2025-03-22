# Demo

```bash
docker build -t backuper src
ssh-keygen -q -f example/keys/id_backuper -N '' <<< y
docker compose --project-directory example up --build
```

# Usage

## docker-compose.yml

```yaml
services:
  backuper:
    build:
      dockerfile: backuper.Dockerfile
    restart: always
    volumes:
      - backup:/backup
volumes:
  backup:
```

## Dockerfile

```dockerfile
# change version if needed
FROM ghcr.io/kirillsmirnow/backuper:0.0.1
# generate your ssh key to access remote hosts
COPY --chmod=400 keys/id_backuper .ssh/id_ed25519
# create backup configuration files
COPY config /config
```

## Configuration file

```sh
when='0 */2 * * *'                                     # every 2 hours at 00 minutes
remote=user@example.com                                # connect to user@example.com
pre_command='tar zcf "/tmp/backup" -C "/documents" .'  # archive a folder there
source=/tmp/backup                                     # fetch the archive
max_files=10                                           # retain no more than 10 backups
```
