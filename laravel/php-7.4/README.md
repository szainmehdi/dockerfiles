# Laravel Installer

### Usage

```bash
docker run --rm -it -v "$PWD:/app" --user $(id -u):$(id -g) szainmehdi/laravel new my-project
```

### Tips

Add this function to your bash profile to make things easier.

```bash
function laravel () {
	docker run --rm -it -v "$PWD:/app" --user $(id -u):$(id -g) szainmehdi/laravel $@
}
```