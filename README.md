# DevDocker

Le Docker pour les utilisateurs qui veulent une façon plus simple de débugger
leur code bas-niveau quand leur PC leur fait des misères !

## Installation

Build l'image avec :

```bash
docker build -t dev-env-docker .
```

ATTENTION: Si tu veux utiliser ce docker pour faire de l'assembleur x86-64,
build avec:

```bash
docker build --platform=linux/amd64 -t dev-env-docker .
```

Voici la config recommandée pour lancer le Docker simplement (attention, Zsh est
obligatoire) :

```bash
devdocker () {
    if [ $# -eq 0 ];
    then
        top=$(git rev-parse --show-toplevel 2>/dev/null || echo "")

        if [ -n "$top" ]; then
            REL_PATH="${PWD#$top}"
        else
            REL_PATH=""
            top="$PWD"
        fi
        docker run -it --rm -v "$(git rev-parse --show-toplevel 2>/dev/null || pwd)":/app -w "/app$REL_PATH" dev-env-docker
    else
        if [ "$1" = "check" ] && [ -n "$2" ]
        then
            docker run --rm -v "$(git rev-parse --show-toplevel 2>/dev/null || pwd)":/app -w "/app$REL_PATH" dev-env-docker sh -c "valgrind --leak-check=full --show-leak-kinds=all ./$2"
        else
            docker run --rm -v "$(git rev-parse --show-toplevel 2>/dev/null || pwd)":/app -w "/app$REL_PATH" dev-env-docker sh -c "$*"
        fi
    fi
}
alias dd=devdocker
```

On a alors :

`devdocker` -> Lance le Docker en mode interactif

`devdocker check ./exec` -> Check avec Valgrind l'exécutable donné

`devdocker {command}` -> Exécute une commande avec le Docker, puis l'éteint
