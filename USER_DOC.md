# User Documentation

## Overview
This document explains, in simple terms, how to use the Inception stack included in this repository.

## What services are provided
The exact services depend on the repository contents (check `docker-compose.yml` and `srcs/`). Common services you will typically find in this project:
- Web server (e.g., nginx)
- Application runtime (e.g., PHP-FPM)
- Database (e.g., MySQL/MariaDB)
- Administration UI (e.g., phpMyAdmin)
- Other helpers (reverse-proxy, monitoring, etc.)

To see the actual services defined for your copy:
```bash
docker compose config --services
```

## Start and stop the project
From the repository root:

Start (build then run in background):
```bash
docker compose up --build -d
```

Stop and remove containers (keep volumes):
```bash
docker compose down
```

Stop and remove containers and volumes:
```bash
docker compose down -v
```

If the repo provides a Makefile, convenient targets may exist:
```bash
make build   # build images
make setup      # start stack
make clean    # stop stack
```

## Access the website and admin panel
- Open the web service in a browser at the host port mapped to the web service (`https://localhost:443`) .
- For admin panels (phpMyAdmin or similar), check `docker-compose.yml` for the mapped host port (e.g., `8080`) and open `http://localhost:<port>`.

To discover mapped ports:
```bash
docker  ps
```

## Locate and manage credentials
- Look for `.env.sample` in the repo root. Secrets and runtime configuration are often provided via environment variables.
- you need to create and fill a `.env` file (in the same path you found in the `.env.sample`) that have the same variables as the .sample but with yours, then youn can run the project.
- For local development, credentials may be in `.env` (do NOT commit secrets).
- For production-like setups, use Docker Secrets or an external secrets manager.
- To inspect current environment variables for a running container:
```bash
docker exec <service-name> env
```
- To view files that initialize credentials (e.g., SQL init scripts), search `srcs/`:
```bash
grep -R "PASSWORD" -n srcs || grep -R "root:" -n srcs
```

## Check that services are running correctly
- List running containers:
```bash
docker compose ps
docker ps
```
- Follow logs:
```bash
docker compose logs -f
```
- Check HTTP endpoints:
```bash
curl -I https://localhost:443
```
- Enter a container to run diagnostics:
```bash
docker compose exec -it <service-name> /bin/bash
```
- Check database connectivity (example for MySQL):
```bash
docker compose exec mariadb mysql -u
```
