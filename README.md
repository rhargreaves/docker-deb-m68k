# Introduction

Dockerfile based bare-metal m68k-elf toolchain with newlib.

The Dockerfile builds a Debian Bullseye image with `make` and an `m68k-elf-gcc` toolchain for bare metal targets. The Dockerfile also builds `newlib` for the toolchain to have a standard C library implementation ready to use.

The repository contains a GitLab CI/CD script that automatically builds the docker images on new tags, and pushes them to the GitLab registry, so you do not need to build the image yourself, you can just pull it from the GitLab registry.

The entry point and command directly run `make`. Thus if you run the container mapping the directory of a Makefile based project to `/m68k`, the container will directly try building the project.

# Usage

## Building local projects

To build a Makefile based project, you can run make from the Docker image as follows:

```bash
$ docker run --rm -v $PWD:/m68k -t registry.gitlab.com/doragasu/docker-deb-m68k
```

The first time you run the command, Docker should fetch the container from the registry and run it.

If you need to pass additional arguments, you have to specify `-c` switch along with the arguments surrounded by double quotes. E.g. to clean a Makefile based project, run:

```bash
$ docker run --rm -v $PWD:/m68k -t registry.gitlab.com/doragasu/docker-deb-m68k -c "make clean"
```

If you prefer staying inside the docker container, you can get an interactive shell by setting the `-i` (interactive) flag and starting bash:

```bash
$ docker run --rm -v $PWD:/m68k -it registry.gitlab.com/doragasu/docker-deb-m68k -c bash
```

You do not want to type these long commands above, so it is recommended to use a script to launch them for you.

Note that this Docker container runs as unprivileged `m68k` user, and home is set to `/m68k`.

## Using container to build projects with GitLab CI/CD

You can use this container for GitLab CI/CD to automatically build your m68k projects. For an example about how to do this, you can have a look to the `.gitlab-ci.yml` file in project [Megadrive Tasking](https://gitlab.com/doragasu/megadrive-tasking)
