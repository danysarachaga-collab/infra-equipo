# Infra Equipo

Repositorio de infraestructura de la semana 8.

## Descripción
Contiene el docker-compose.yml de la semana 7 (nginx, php y mysql).

## Requisitos
- Ubuntu 22.04
- Docker y Docker Compose instalados
- Git configurado con SSH

## Cómo desplegar
    git clone git@github.com:danysarachaga-collab/infra-equipo.git
    cd infra-equipo
    cp .env.example .env
    nano .env
    docker compose up -d

El archivo .env guarda la contraseña de MySQL y no se sube al repositorio.

