COMPOSE_BASE := "docker compose -f examples/docker-compose.yaml"

build:
    docker build -t sakkenix-base:latest .

up:
    {{COMPOSE_BASE}} up -d

down:
    {{COMPOSE_BASE}} down

exec *ARGS:
    {{COMPOSE_BASE}} exec base zsh {{ARGS}}

logs:
    {{COMPOSE_BASE}} logs -f

ssh-check:
    {{COMPOSE_BASE}} exec base ssh-add -l

clean:
    {{COMPOSE_BASE}} down -v --remove-orphans
