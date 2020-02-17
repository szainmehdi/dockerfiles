# Node 12.10

Based on the [official `node:12.10-alpine` docker image](https://hub.docker.com/_/node), this adds:
- `git`
- `yarn`
- 'vue-cli'

### Usage
Dockerfile
```dockerfile
FROM szainmehdi/node:12.10
```

Docker Compose
```yaml
image: szainmehdi/node:12.10
```
