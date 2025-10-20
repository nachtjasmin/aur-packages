DOCKER_IMAGE := 'aur-builder'

_default: build-all

_image:
    podman build -f .github/actions/aur/Dockerfile -t {{ DOCKER_IMAGE }}

build package: _image
    podman run --rm -e 'INPUT_PKGNAME={{ package }}' \
    -e 'GITHUB_WORKSPACE=/work' \
    -v $PWD:/work:z \
    {{ DOCKER_IMAGE }}

build-all: (build 'kluctl')
