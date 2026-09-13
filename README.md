# reverse-proxy-performance-analysis
PERFORMANCE ANALYSIS OF NGINX, APACHE, AND HAPROXY AS REVERSE PROXIES USING STEP LOAD TESTING AND RESOURCE LIMITING IN DOCKER SWARM

# Topologi
- Ubuntu + Docker
- Nginx, Apache, HAProxy dalam container
- Uji beban bertahap 100–1000 req/s
- Resource limiting CPU & memori

# Project Structure
- `nginx/` — Nginx configuration and web pages
- `apache/` — Apache configuration and web pages
- `haproxy/` — HAProxy configuration
- `scripts/` — Testing and monitoring scripts
- `results/` — Raw testing data and results
- `docs/` — Flowcharts, reports, and graphs

## How to Run
```bash
docker-compose up -d
