# Custom Caddy image with the Porkbun DNS provider plugin compiled in.
# Needed for ACME DNS-01 certificate challenges, which let Caddy obtain/renew
# Let's Encrypt certs without any public inbound connectivity (required when the
# server is reachable only over Tailscale).
FROM caddy:2-builder AS builder
RUN xcaddy build \
    --with github.com/caddy-dns/porkbun

FROM caddy:2
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
