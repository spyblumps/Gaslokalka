#!/usr/bin/env bash
set -euo pipefail

# Путь к базе лаунчера
S="$HOME/AppData/Roaming/Space Station 14/launcher/settings.db"

if [ ! -f "$S" ]; then
    echo "❌ Ошибка: Не найден файл settings.db. Убедитесь, что зашли в лаунчер."
    exit 1
fi

# Жесткий путь к sqlite3
SQLITE3_EXE="D:/gassy_data/Goob-Station/bin/Content.Client/sqlite3.exe"
TOK=$(cmd //c "$SQLITE3_EXE" "$S" "SELECT Token FROM Login LIMIT 1")
MY_UID=$(cmd //c "$SQLITE3_EXE" "$S" "SELECT UserId FROM Login LIMIT 1")

if [ -z "$TOK" ] || [ -z "$MY_UID" ]; then
    echo "❌ Пустой токен — зайди в лаунчер и войди в аккаунт!"
    exit 1
fi

echo "✅ Токен и UserID успешно получены."

export ROBUST_DISABLE_SANDBOX=1
export SAIGA_MCP_CLIENT=1
export SAIGA_MCP_TOKEN=devsecret
export ROBUST_AUTH_TOKEN="$TOK"
export ROBUST_AUTH_USERID="$MY_UID"
export ROBUST_AUTH_SERVER="https://auth.spacestation14.com/"

# --- ГЛАВНЫЙ ФИКС ---
# Мы жестко указываем движку, где лежат файлы контента, через переменную окружения
export ROBUST_CONTENT_PATH="D:/gassy_data/Goob-Station"
# --------------------

SERVER_IP="185.97.255.20"
PORT="4003"

echo "🚀 Запускаем клиент на $SERVER_IP:$PORT..."

# Запускаем без --data-dir, потому что клиент его не понимает
dotnet "D:/gassy_data/Goob-Station/bin/Content.Client/Robust.Client.dll" \
  --connect \
  --connect-address udp://$SERVER_IP:$PORT \
  --cvar net.connection_timeout=120