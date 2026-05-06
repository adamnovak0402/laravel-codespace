# Laravel Codespace

Vývojové prostředí pro PHP/Laravel připravené pro GitHub Codespaces.

## Jak začít

### 1. Forkni repozitář
Klikni na **Fork** v pravém horním rohu na GitHubu.

### 2. Otevři Codespace
Na svém forku klikni na **Code → Codespaces → Create codespace on main**.

> Počkej 2–3 minuty, než se prostředí sestaví (první spuštění).

### 3. Spusť vývojový server
```bash
php artisan serve --host=0.0.0.0 --port=8000
```
Codespace automaticky otevře browser s aplikací.

---

## Co je předinstalováno

| Nástroj | Verze |
|---------|-------|
| PHP | 8.3 |
| Composer | latest |
| Node.js | 22 |
| MySQL | 8.0 |
| Laravel | latest |

## Užitečné příkazy

```bash
# Migrace databáze
php artisan migrate

# Seed databáze
php artisan db:seed

# Artisan tinker (REPL)
php artisan tinker

# Výpis všech routes
php artisan route:list

# Sestavení frontendu (Vite)
npm run dev
```

## Přihlašovací údaje k databázi

| | |
|---|---|
| Host | `db` |
| Database | `laravel` |
| Username | `laravel` |
| Password | `secret` |
