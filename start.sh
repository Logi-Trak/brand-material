#!/bin/sh
set -e

caddy run --config /app/Caddyfile --adapter caddyfile &
CADDY_PID=$!

trap 'kill -TERM $CADDY_PID 2>/dev/null' TERM INT

exec oauth2-proxy --http-address="0.0.0.0:${PORT:-8080}"
