# Deployment Guide

## Overview

This document outlines the deployment strategies and processes for the DevOps Practice Project.

## Environments

### Development
- **Purpose**: Local development and testing
- **Access**: Local machine only
- **Port**: 3000 (configurable via PORT env var)
- **Command**: `npm run dev` or `make dev`

### Staging
- **Purpose**: Pre-production testing and validation
- **Access**: Internal team
- **Deployment**: Automated via CI/CD on develop branch
- **Monitoring**: Basic health checks and logging

### Production
- **Purpose**: Live application serving users
- **Access**: Public
- **Deployment**: Automated via CI/CD on main branch merge
- **Monitoring**: Full observability stack

## Deployment Methods

### 1. Local Development

```bash
# Install dependencies
npm install

# Start development server with hot reload
npm run dev

# Or use make command
make dev
```

### 2. Docker Deployment

```bash
# Build Docker image
docker build -t my-devops-project .

# Run container
docker run -d -p 3000:3000 --name my-app my-devops-project

# Or use make commands
make docker-build
make docker-run
```

### 3. Docker Compose Deployment

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Or use make commands
make docker-compose-up
make docker-compose-logs
make docker-compose-down
```

### 4. CI/CD Pipeline Deployment

The application uses GitHub Actions for automated deployment:

1. **On Push to develop**: Runs tests and deploys to staging
2. **On Push to main**: Runs tests and deploys to production
3. **On Pull Request**: Runs tests and security scans

## Health Checks

The application provides several endpoints for monitoring:

- `GET /health` - Basic health check
- `GET /` - Application status
- `GET /info` - Application information

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | 3000 | Server port |
| `NODE_ENV` | development | Environment mode |

## Rollback Strategy

### Automated Rollback
- Failed health checks trigger automatic rollback
- Database migration failures prevent deployment

### Manual Rollback
```bash
# Using Docker
docker pull my-devops-project:previous-tag
docker stop my-app
docker rm my-app
docker run -d -p 3000:3000 --name my-app my-devops-project:previous-tag

# Using git (for local development)
git revert <commit-hash>
git push origin main
```

## Monitoring and Alerting

### Health Monitoring
- Automated health checks every 30 seconds
- Email alerts on consecutive failures
- Slack notifications for deployment events

### Performance Monitoring
- Response time tracking
- Error rate monitoring
- Resource utilization alerts

### Log Aggregation
- Centralized logging with structured JSON format
- Log rotation and retention policies
- Search and filtering capabilities

## Troubleshooting

### Common Issues

1. **Container won't start**
   ```bash
   # Check logs
   docker logs my-app
   
   # Check if port is in use
   lsof -i :3000
   ```

2. **Health check failures**
   ```bash
   # Test health endpoint
   curl http://localhost:3000/health
   
   # Check application logs
   make docker-logs
   ```

3. **Performance issues**
   ```bash
   # Check resource usage
   docker stats my-app
   
   # Monitor application metrics
   curl http://localhost:3000/info
   ```

### Debug Mode

Enable debug logging:
```bash
DEBUG=* npm start
```

## Security Considerations

### Container Security
- Running as non-root user (when implemented)
- Minimal base image (Alpine Linux)
- Regular security scans with Trivy

### Network Security
- HTTPS in production (reverse proxy)
- Rate limiting on public endpoints
- Input validation and sanitization

### Secrets Management
- No secrets in source code
- Environment-based configuration
- Secure secret storage solutions

## Best Practices

1. **Zero-Downtime Deployment**
   - Blue-green deployment strategy
   - Health check validation before traffic switch
   - Gradual traffic migration

2. **Database Migrations**
   - Backward-compatible changes
   - Migration rollback procedures
   - Data backup before migrations

3. **Configuration Management**
   - Environment-specific configurations
   - Version-controlled infrastructure
   - Immutable infrastructure principles

4. **Monitoring and Observability**
   - Comprehensive logging
   - Metrics collection and visualization
   - Distributed tracing (for microservices)

## Getting Help

- Check the [Learning Guide](./LEARNING_GUIDE.md) for DevOps concepts
- Review application logs for error details
- Test locally before deploying to staging
- Use the health check endpoints to verify deployment success

---

For questions or issues, please refer to the project documentation or create an issue in the repository.