#!/bin/bash
set -e

echo "==> Nastavuji prostředí..."

# Pokud ještě neexistuje composer.json (nový fork bez Laravelu), nainstaluj Laravel
if [ ! -f "composer.json" ]; then
    echo "==> Instaluji nový Laravel projekt..."
    composer create-project laravel/laravel . --prefer-dist
fi

# Nainstaluj PHP závislosti
echo "==> Instaluji Composer závislosti..."
composer install --no-interaction --prefer-dist --optimize-autoloader

# Vytvoř .env pokud neexistuje
if [ ! -f ".env" ]; then
    echo "==> Vytvářím .env soubor..."
    cp .env.example .env
    php artisan key:generate
fi

# Nastav DB connection v .env (hodnoty z docker-compose)
sed -i 's/DB_CONNECTION=.*/DB_CONNECTION=mysql/' .env
sed -i 's/DB_HOST=.*/DB_HOST=db/' .env
sed -i 's/DB_PORT=.*/DB_PORT=3306/' .env
sed -i 's/DB_DATABASE=.*/DB_DATABASE=laravel/' .env
sed -i 's/DB_USERNAME=.*/DB_USERNAME=laravel/' .env
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=secret/' .env

# Nainstaluj Node závislosti
if [ -f "package.json" ]; then
    echo "==> Instaluji npm závislosti..."
    npm install
fi

# Počkej na MySQL (může trvat chvíli při prvním spuštění)
echo "==> Čekám na databázi..."
until mysql -h db -u laravel -psecret laravel -e "SELECT 1" &>/dev/null; do
    sleep 2
done

# Spusť migrace
echo "==> Spouštím migrace..."
php artisan migrate --force

echo ""
echo "✓ Hotovo! Spusť server příkazem:"
echo "  php artisan serve --host=0.0.0.0 --port=8000"
