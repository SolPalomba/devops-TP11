#!/bin/bash

ERRORS=0
ok()   { echo "  [OK]   $1"; }
fail() { echo "  [FAIL] $1"; ERRORS=$((ERRORS+1)); }

echo "=== Verificación TP11 — Terraform + Docker ==="
echo ""

echo "--- Contenedores ---"
for c in devops-portfolio-dev-db devops-portfolio-dev-frontend; do
    ST=$(docker inspect --format='{{.State.Status}}' "$c" 2>/dev/null || echo "no encontrado")
    [ "$ST" = "running" ] && ok "$c" || fail "$c → $ST"
done

echo ""
echo "--- Red Docker ---"
NET=$(docker network ls --filter name=devops-portfolio-dev-network --format '{{.Name}}')
[ -n "$NET" ] && ok "Red: $NET" || fail "Red no encontrada"

echo ""
echo "--- Volumen Postgres ---"
VOL=$(docker volume ls --filter name=devops-portfolio-dev-postgres-data --format '{{.Name}}')
[ -n "$VOL" ] && ok "Volumen: $VOL" || fail "Volumen no encontrado"

echo ""
echo "--- Endpoint frontend ---"
CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 http://localhost:8080)
[ "$CODE" = "200" ] && ok "Frontend → HTTP $CODE" || fail "Frontend → HTTP $CODE"

echo ""
echo "--- Terraform state ---"
RESOURCES=$(terraform state list 2>/dev/null | wc -l)
[ "$RESOURCES" -gt 0 ] && ok "$RESOURCES recursos en state" || fail "State vacío"

echo ""
[ "$ERRORS" -eq 0 ] && echo "Stack OK" || echo "$ERRORS errores"
