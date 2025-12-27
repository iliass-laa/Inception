*This project has been created as part of the 42 curriculum by ilaasri.*

# Inception

## Description
Inception is a 42 curriculum project that demonstrates how to deploy a small multi-service platform using Docker. The goal is to design, build, and run a set of containerized services (web server, database, monitoring, etc.) on a single host while applying best practices for containerization, networking, and data persistence.

This repository contains the configuration and sources needed to build each service as a Docker image and to orchestrate them together (typically via a docker-compose file or equivalent scripts). The project emphasizes reproducibility, minimal privileged access, and separation of concerns between services.

## Project description (Docker, sources, and design choices)

- Purpose of Docker in this project
  - Docker is used to provide lightweight, reproducible, and isolated environments for each service.
  - Containers encapsulate each service's runtime, dependencies and configuration so the whole stack can be built and started consistently on any machine with Docker installed.

- Sources included in this repository
  - srcs/ (or similar): per-service folders containing Dockerfiles, configuration files (nginx conf, php-fpm pool, SQL init scripts, monitoring configs), and assets required to build each service image.
  - docker-compose.yml (or orchestration scripts): describes how services are connected, networks, volumes and environment configuration.
  - tools/ or scripts/: helper scripts for building, seeding databases, and cleaning up.
  - README.md: this file explaining how to build and run the project.

- Main design choices
  - Single-host Docker Compose approach: use docker-compose to orchestrate multiple containers on one host. This keeps complexity low while demonstrating service separation and network configuration.
  - Minimal base images & multi-stage builds: where applicable, use multi-stage Dockerfiles to produce small final images.
  - Use of official, well-maintained images for standard services (e.g., database engines) to reduce surface for errors and security issues.
  - Persistent storage via Docker Volumes for data that must survive container recreation (databases, uploads).
  - Explicit networks (bridge) to limit exposure between services while allowing controlled inter-service communication.

## Comparisons and rationale

- Virtual Machines vs Docker
  - Virtual Machines
    - Pros: Stronger isolation (separate kernel), mature tooling for full OS-level control.
    - Cons: Heavyweight (CPU/RAM/storage overhead), slower startup, less portable in development workflows.
  - Docker
    - Pros: Lightweight, fast startup, image portability, ideal for microservice-style deployments and reproducible dev environments.
    - Cons: Weaker kernel-level isolation (shares host kernel), subtle differences from full VM environments, security considerations.
  - Rationale in this project: Docker is preferred for speed, portability, and resource efficiency during development and for the single-host deployment target of the Inception project.

- Secrets vs Environment Variables
  - Environment Variables
    - Pros: Simple to use and supported everywhere.
    - Cons: Often visible in process listings, docker inspect output, or CI logs; less secure for sensitive data.
  - Secrets (Docker Secrets, Vault, etc.)
    - Pros: Designed to store sensitive data with restricted access, not exposed through image layers or container environment.
    - Cons: Slightly more complex to set up; Docker Secrets require swarm mode or external secret stores in non-swarm setups.
  - Rationale in this project: Use environment variables for non-sensitive configuration and local development convenience. Use Docker Secrets (or other secret management) for production or when handling credentials that must not appear in the environment or repo.

- Docker Network vs Host Network
  - Bridge/Custom Docker Network
    - Pros: Provides isolation between containers and from the host; allows name-based discovery; prevents accidental port conflicts.
    - Cons: Slight NAT overhead; needs port mapping to reach host network.
  - Host Network
    - Pros: Lowest latency and overhead; ports map directly to host.
    - Cons: No network namespace isolation; port conflicts with host services; less secure/isolation.
  - Rationale in this project: Use custom bridge networks to isolate services and enable DNS-based service discovery while mapping only the necessary ports to the host (e.g., http/https).

- Docker Volumes vs Bind Mounts
  - Docker Volumes
    - Pros: Managed by Docker, portable across hosts when using volume drivers, good performance on most platforms, safer (not tied to host paths).
    - Cons: Less transparent to the developer when debugging host filesystem contents.
  - Bind Mounts
    - Pros: Direct access to host filesystem (useful for local development and live code editing).
    - Cons: Can cause portability issues, permission mismatches and may lead to leaking host information into containers.
  - Rationale in this project: Use Docker Volumes for persistent data (databases, uploads). Use bind mounts selectively during development for live code iteration.

## Instructions

Prerequisites
- Docker (engine) installed (e.g., Docker Engine >= 20.10).
- docker-compose (v1) or Docker Compose plugin (docker compose) available.
- (Optional) make for convenience if a Makefile is provided.

Basic steps (typical)
1. Clone the repository
   ```bash
   git clone https://github.com/iliass-laa/Inception.git
   cd Inception
   ```

2. Inspect configuration
   - Review docker-compose.yml, srcs/* Dockerfiles and any .env files before launching.
   - Ensure no secrets (passwords/keys) are committed to the repo. Use .env or Docker secrets for sensitive values.

3. Build and start the stack
   - With Docker Compose:
     ```bash
     docker compose up --build -d
     ```
     or (older docker-compose binary)
     ```bash
     docker-compose up --build -d
     ```
   - with a Makefile you can use:
     ```bash
     make build
     make up
     ```

4. Verify
   - List running containers:
     ```bash
     docker ps
     ```
   - Follow logs:
     ```bash
     docker compose logs -f
     ```
   - Access services in your browser at the mapped ports (common examples)
     - Web service: http://localhost:80 (if configured)
     - Admin UI or monitoring: http://localhost:8080 or as documented in the repo

5. Stop and remove
   ```bash
   docker compose down
   ```
   - If you want to remove volumes:
     ```bash
     docker compose down -v
     ```

Notes and tips
- If you need to change secrets, create a .env file (and add it to .gitignore) or configure Docker secrets for production.
- For rebuilding a single service after changes:
  ```bash
  docker compose build <service-name>
  docker compose up -d <service-name>
  ```

## Resources

Classic references and documentation
- Docker overview and documentation: https://docs.docker.com/
- Docker Compose: https://docs.docker.com/compose/
- Dockerfile best practices: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- 42 Network / Inception project guidelines (check your campus intranet or project PDF)
- Articles and tutorials:
  - "A Beginner's Guide to Docker" — official Docker tutorials
  - "12 Factor App" — for app configuration and environment handling

How AI was used
- This README was drafted with assistance from an AI (GitHub Copilot / OpenAI ChatGPT). The AI helped:
  - Structure and wording of the README (sections, comparisons, commands).
  - Providing general explanations and comparisons (VM vs Docker, secrets vs env vars, etc.).
- What AI did NOT do:
  - No production code or service configuration was generated or injected into the repository by the AI in this step (only documentation content was drafted).
- If you used AI to generate code/configuration in other parts of the repo, document those files and verify them manually for security and correctness before use in production.

## Features (example)
- Containerized multi-service architecture
- Persistent data using Docker Volumes
- Per-service Dockerfiles for reproducible builds
- Service isolation via Docker networks

## Project structure (example)
- README.md — this file
- docker-compose.yml — orchestration (if present)
- srcs/
  - service1/
    - Dockerfile
    - conf/
  - service2/
    - Dockerfile
    - conf/
- tools/ or scripts/ — helper scripts

## Contributing
- Follow the repository's code style and Docker best practices.
- Do not commit secrets (passwords, API keys). Use .env in .gitignore or a secrets manager.
- Open issues or pull requests describing the change and motivation.

## Troubleshooting
- Permission denied when using Docker volumes: check file ownership/UID mapping between host and container.
- Port already in use: check host processes or use different host port mappings in docker-compose.yml.
- Container failing to start: inspect logs with docker compose logs <service>.


---

If you want, I can:
- tailor the Instructions section to the exact filenames and services in your repo (I can inspect the repository to list Dockerfiles, docker-compose.yml, and actual ports),
- or produce a Makefile / convenience scripts to build and manage the stack.

Which would you like me to do next?