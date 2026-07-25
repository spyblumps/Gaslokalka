@echo off
chcp 65001 >nul

:: -----------------------------------------------
:: ВСТАВЬТЕ СЮДА ВАШИ ДАННЫЕ ИЗ DB BROWSER
:: -----------------------------------------------
set "ROBUST_AUTH_TOKEN=ne69p9JxeVWpgCclpqlKipHaTWYDO0SPzR9QvRcScWM="
set "ROBUST_AUTH_USERID=71A3B799-FCC8-4F38-8A8A-E7954AA002B8"
:: -----------------------------------------------

if "%ROBUST_AUTH_TOKEN%"=="" (
    echo ❌ Вы не вставили токен в файл!
    pause
    exit /b 1
)

set ROBUST_DISABLE_SANDBOX=1
set SAIGA_MCP_CLIENT=1
set SAIGA_MCP_TOKEN=devsecret
set ROBUST_AUTH_SERVER=https://auth.spacestation14.com/

echo 🚀 Запускаем клиент на 185.97.255.20:4003...

dotnet run --project Content.Goobstation.Client -- --connect --connect-address udp://185.97.255.20:4003 --cvar net.connection_timeout=120

pause