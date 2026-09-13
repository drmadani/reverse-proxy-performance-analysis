# reverse-proxy-performance-analysis

Performance analysis of Apache, Nginx, and HAProxy web servers using gradual load testing and resource limiting scenarios in a Docker environment. This repository contains the configuration, testing scripts, and results for my final project.


## Topology
- Ubuntu + Docker
- Nginx, Apache, HAProxy inside containers
- Step load testing 100–1000 req/s
- CPU & memory resource limiting

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
