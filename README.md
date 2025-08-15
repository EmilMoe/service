# Service

This repository is a foundation for building and publishing a PHP-based Docker image. It currently contains a Dockerfile defining the runtime environment and a GitHub Actions workflow that automates image building and publishing. There is no application code yet—this repo mainly sets up infrastructure.

## Key Components

- **Dockerfile**
  Defines a PHP 8.3 CLI image. Installs common extensions (e.g., pdo_mysql, mbstring, gd, redis) and tools (git, curl, supervisor, MySQL client). Sets the final user to `www-data` and the working directory to `/app`.
- **GitHub Actions workflow**
  On every push to `main`, checks out the repo, logs in to GitHub Container Registry, builds the Docker image tagged `ghcr.io/emilmoe/service:latest`, and pushes it to the registry.

## Next Steps & Resources

1. **Add application code**
   Populate `/app` with your PHP service, add a `COPY` command in the Dockerfile, and configure entry points or services.
2. **Learn more about PHP & extensions**
   Explore how the installed extensions (pdo_mysql, redis, gd, etc.) support typical web/service functionality.
3. **Docker & CI/CD basics**
   Review Docker best practices (layer caching, multi-stage builds) and GitHub Actions documentation for advanced workflows.
4. **Secrets management**
   Investigate secure management of PAT tokens and consider using more granular access tokens or workload identities.

