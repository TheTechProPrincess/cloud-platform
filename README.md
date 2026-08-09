## cloud-platform

A DevOps pipeline project simulating real-world infrastructure automation:
IaC, CI/CD, containerization, orchestration, and monitoring — built
incrementally with real branches, commits, and pull requests.

## What's in here

- **infrastructure/bicep/** — reusable Bicep template deploying a storage
  account, app service plan, and web app; parameterized for sandbox, dev,
  and prod environments
- **.github/workflows/** — CI/CD pipeline that validates the Bicep template
  and runs a security scan (Checkov), failing the build on critical issues
- **application/** — a small Node.js health-check API, containerized with
  a minimal Alpine-based Dockerfile with a built-in HEALTHCHECK
- **kubernetes/dev/** — deployment config with liveness/readiness probes
  tied to the app's /health endpoint, plus CPU/memory resource limits
- **monitoring/** — Prometheus scrape config and an alert rule that fires
  after 1 minute of sustained downtime (tuned to avoid false alarms from
  Kubernetes' own self-healing)
- **scripts/** — a bash script that checks pod health, distinguishing
  pods that are down vs. pods that are running but failing readiness
