# ARTIQ docker recipe

This repository contains the recipe for an ARTIQ docker image powered by [Miniconda](http://conda.pydata.org/miniconda.html) and scripts that makes using ARTIQ container easier. 

[Image available on Dockerhub](https://hub.docker.com/r/quartiq/artiq/).

## Features

- Full ARTIQ development environment
- Can use ARTIQ / MiSoC / Migen sources from specified directory (ease of development)
- In container acts as current user
- Exposed ports and GUI
- Interactive shell or given command
- `ttyUSB*` available in container

## Deploy

    $ docker pull quartiq/artiq:latest

## Building image locally

    $ docker build . -t quartiq/artiq:latest

## Using `dartiq` sctipt

To use full-featured ARTIQ in Docker container must be run with several arguments and that is what `dartiq` script was created for. It offers two way of dealing with container: running an interactive shell or a specified command. Additionally it allows to specify user to act as in the container, workspace directory, path to HDL toolchain and sources for ARTIQ / MiSoC / Migen to be installed and used in the container. If no sources are given, built-in are used.

```
dartiq [options] [command]
  
Run ARTIQ in Docker container.

When no command is supplied an interactive shell with ARTIQ environment enabled is started.
Otherwise supplied command is started in ARTIQ environment.

Options:

  --user <USER>
      in the container act as a USER, defaults to current user
  --workspace <DIRECTORY>
      direcotry to be mounted as /home/workspace and be a default home directory when running
      in non-root mode, defaults to current directory
  --gateware-toolchain
      path to gatware toolchain, in case of Xilinx Vivado it should point to the directory 
      where Vivado directory is located
  --artiq <DIRECTORY>
      directory from which is to be used as ARTIQ sources
  --misoc <DIRECTORY>
      directory from which is to be used as MiSOC sources
  --migen <DIRECTORY>
      directory from which is to be used as Migen sources
      
Environmental variables used:

  ARTIQ_DOCKER_TOOLS_PATH - equivalent of gateware-toolchain option
  ARTIQ_DOCKER_ARTIQ_PATH - equivalent of artiq option
  ARTIQ_DOCKER_MISOC_PATH - equivalent of misoc option
  ARTIQ_DOCKER_MIGEN_PATH - equivalent of migen option

NOTE 1: Options have higher priority then environmental variables.
NOTE 2: If no Artiq source is supplied version from the image is used.
```
## TODO:

* use/link repo/databases/results
* expose ports, GUI
* run
* make image for CLI only (master, ctlmgr)
