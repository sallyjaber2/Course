## CI/CD Pipeline (GitHub Actions)

This repo includes a CI/CD pipeline that builds and pushes a Docker image on both branches:

- **dev** branch → pushes image tag: `snapshot`
- **main** branch → pushes image tags: `latest` and `${GITHUB_SHA}`

### Workflow Jobs
1. **Build**: build Docker image
2. **Push**: push image to registry
3. **Promote**: tag the same image as `latest` (main) or `snapshot` (dev)
4. **Deploy**: (next step) deploy dev as Docker containers and main on Kubernetes

### Local Run (example)
```bash
docker pull sallyjaber2/djangoblog:latest
docker run --rm --platform linux/amd64 -p 8000:8000 sallyjaber2/djangoblog:latest

