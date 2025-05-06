# DevDocker

Le Docker pour les utilisateurs de MacOS qui veulent une façon plus simple de
débugger leur code bas-niveau !

## Installation

Build l'image avec :

```bash
docker build -t dev-env-docker .
```

Voici la config recommandée pour lancer le Docker simplement :

```bash
devdocker () {
	if [ $# -eq 0 ]
	then
		docker run --platform linux/amd64 -it --rm -v "$(pwd)":/app dev-env-docker
	else
		if [ "$1" = "check" ] && [ -n "$2" ]
		then
			docker run --platform linux/amd64 --rm -v "$(pwd)":/app dev-env-docker sh -c "valgrind --leak-check=full --show-leak-kinds=all ./$2"
		else
			docker run --platform linux/amd64 --rm -v "$(pwd)":/app dev-env-docker sh -c "$*"
		fi
	fi
}
```

On a alors :

`devdocker` -> Lance le Docker en mode interactif

`devdocker check ./exec` -> Check avec Valgrind l'exécutable donné

`devdocker {command}` -> Exécute une commande avec le Docker, puis l'éteint
