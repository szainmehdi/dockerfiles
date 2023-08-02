# Node 16

Based on the [official `node:16-alpine` docker image](https://hub.docker.com/_/node), this adds:
- `git`
- `yarn`
- 'vue-cli'

### Usage
Dockerfile
```dockerfile
FROM szainmehdi/node:16
```

Docker Compose
```yaml
image: szainmehdi/node:16
```
