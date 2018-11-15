# ARTIQ docker recipe

This repository contains the recipe for an ARTIQ docker image powered by [Miniconda](http://conda.pydata.org/miniconda.html) and scripts that makes using ARTIQ container easier. 

[Image available on Dockerhub](https://hub.docker.com/r/quartiq/artiq/).

## Features

- Full ARTIQ development environment
- Can use ARTIQ / MiSoC / Migen sources from specified directory (ease of development)
- In container acts as current user with option to mount specified directory as a home
- Workspace directory can be mounted from host
- GUI can be run from the container (both ARTIQ-related and Vivado)
- Interactive shell or given command execution
- `ttyUSB*` available in container

## Deploy

    $ docker pull quartiq/artiq:latest

## Building image locally

    $ docker build . -t quartiq/artiq:latest

## Using `dartiq` sctipt

To use full-featured ARTIQ in Docker container must be run with several arguments and that is what `dartiq` script was created for. It offers two ways of dealing with container: running an interactive shell or a specified command to run. 

Additionally it allows to specify user to act as in the container, mount host directory as home and workspace, give path to gateware toolchain and provide external sources for ARTIQ / MiSoC / Migen to be installed and used in the container. If no sources are given, built-in are used.

## TODO:

* use/link repo/databases/results
* make image for CLI only (master, ctlmgr)
