# Developer Documentation

How to set up, build, run and manage the project.

## Prerequisites
- Docker Engine installed
- Docker Compose (or Docker CLI plugin supporting `docker compose`)
- git
- Make

## Setup from scratch
1. Clone the repo:
```bash
git clone https://github.com/iliass-laa/Inception.git
cd Inception
```

2. Configuration and secrets:
- Copy the sample environment file if present:
```bash
cp .env.sample .env
```
- Edit `.env` to set local values (database passwords, ports). Add `.env` to `.gitignore`.
- If using Docker Secrets for sensitive data, create them before launching (example):
```bash
echo "my_db_password" | docker secret create db_root_password -
```
(Secrets require swarm mode or an external secrets manager; for local dev you can keep secrets in `.env`.)

## Build and launch (Makefile + Docker Compose)
If repository provides a Makefile, use the documented targets:
```bash
make build   # builds images
make up      # starts the full stack (background)
make clean    # stops and removes containers
```
Or just the Old Way :
``` bash 
make # this will build  and starts the stack
make fclean # this will stops the container and remove the Volumes even the mounted ones
```

Alternatively with Docker Compose directly:
```bash
docker compose up --build -d
docker compose logs -f
docker compose down
```

Rebuild a single service:
```bash
docker compose build <service-name>
docker compose up -d <service-name>
```

## Useful commands for container and volume management
- List services/containers:
```bash
docker compose ps
docker ps
```
- View logs:
```bash
docker compose logs -f
docker compose logs <service-name>
```
- Execute a shell inside a running container:
```bash
docker compose exec <service-name> /bin/bash
```
- Remove dangling images and unused volumes:
```bash
docker image prune
docker volume prune
```
- Remove volumes created by the compose stack:
```bash
docker compose down -v
```
- Inspect volumes:
```bash
docker volume ls
docker volume inspect <volume-name>
```

## Where project data is stored and how it persists
- Persistent data is defined in `docker-compose.yml` under the `volumes:` section.
  - Docker Volumes: abstracted by Docker and managed separately from host filesystem (recommended for DB data).
  - Bind mounts: if used, point to a host path and are listed under `volumes:` or `volumes` mapping in service definitions.
- To find where a named Docker volume stores data on the host:
```bash
docker volume inspect <volume-name>
```
- Typical locations:
  - Docker-managed volumes: managed by Docker (location depends on platform).
  - Bind mount example: `./srcs/mysql/data:/var/lib/mysql` — host path `./srcs/mysql/data` persists data.

## Notes and tips
- Keep secrets out of the repository. Use `.env` + `.gitignore` for local dev and Docker Secrets or a secret manager for production.
- Use multi-stage builds in Dockerfiles to keep images small and reproducible.
- Check `docker-compose.yml` for exact service names and volume names used by the project.
