# Example

```bash
docker build -t backuper src
ssh-keygen -q -f example/keys/id_backuper -N '' <<< y
docker compose --project-directory example up --build
```
