# Node 13

Based on the [official `node:13-alpine` docker image](https://hub.docker.com/_/node), this adds:
- `git`
- `yarn`
- 'vue-cli'

### Usage
Dockerfile
```dockerfile
FROM szainmehdi/node:13
```

Docker Compose
```yaml
image: szainmehdi/node:13
```
