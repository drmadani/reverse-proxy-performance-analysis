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

## Testing Scenarios
All scenarios use [k6](https://k6.io/) running inside Docker (`grafana/k6`).

### Scenario 1: Step Load Testing
Ramps up from 100 to 1000 req/s to find breaking points.
```bash
cd scripts && ./run_scenario1.sh

## Scenario 2: Resource Limiting
Sustained load of 500 VUs against containers with varying CPU/memory limits.
cd scripts && ./run_scenario2.sh

## Scenario 3: HAProxy as Load Balancer
cd scripts && ./run_scenario3.sh
