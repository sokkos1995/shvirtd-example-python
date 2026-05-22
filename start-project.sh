#!/bin/bash

PROJECT_DIR=/opt/shvirtd-example-python
REPO_URL=https://github.com/sokkos1995/shvirtd-example-python.git

if [ ! -d "$PROJECT_DIR" ]; then
  echo "Клонируем репозиторий (ветка task3)..."
  git clone -b task3 "$REPO_URL" "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"
git checkout task3
git pull

echo "Запускаем docker compose..."
docker compose up -d --build

echo "Ждём готовность mysql (healthcheck)..."
for i in $(seq 1 40); do
  status=$(docker inspect mysql --format '{{.State.Health.Status}}' 2>/dev/null || echo "none")
  if [ "$status" = "healthy" ]; then
    echo "mysql healthy"
    break
  fi
  sleep 3
done

echo "Проверка:"
curl -L http://127.0.0.1:8090
