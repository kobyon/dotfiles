COMPOSE_BASE := "docker compose -f examples/docker-compose.yaml"

# Build the base image
build:
    docker build -t sakkenix-base:latest .

# Start the base container
up:
    {{COMPOSE_BASE}} up -d

# Stop the base container
down:
    {{COMPOSE_BASE}} down

# Exec into the running base container
exec *ARGS:
    {{COMPOSE_BASE}} exec base zsh {{ARGS}}

# View base container logs
logs:
    {{COMPOSE_BASE}} logs -f

# Verify SSH agent forwarding in the base container
ssh-check:
    {{COMPOSE_BASE}} exec base ssh-add -l

# Remove container, networks, and volumes
clean:
    {{COMPOSE_BASE}} down -v --remove-orphans
