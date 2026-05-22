#!/bin/bash

PROJECT_DIR=/opt/shvirtd-example-python
REPO_URL=https://github.com/sokkos1995/shvirtd-example-python.git

if [ ! -d "$PROJECT_DIR" ]; then
  echo "Клонируем репозиторий..."
  git clone "$REPO_URL" "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"
git pull

echo "Запускаем docker compose..."
docker compose up -d --build

echo "Ждём старт сервисов..."
sleep 20

echo "Проверка:"
curl -L http://127.0.0.1:8090
