FROM caddy:2-alpine AS caddy-bin
FROM quay.io/oauth2-proxy/oauth2-proxy:v7.6.0 AS oauth2-proxy-bin

FROM alpine:3.20
RUN apk add --no-cache ca-certificates

COPY --from=caddy-bin /usr/bin/caddy /usr/local/bin/caddy
COPY --from=oauth2-proxy-bin /bin/oauth2-proxy /usr/local/bin/oauth2-proxy

WORKDIR /app
COPY index.html nauta-signature-builder.html Caddyfile start.sh ./
RUN chmod +x start.sh

CMD ["./start.sh"]
