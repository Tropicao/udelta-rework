# Installation dockerfiles

This files provide Docker support to replay Repetier installation in clean
environment

## Files
* Dockerfile_[arch] : a dockerfile specific to current system target
* start_docker.sh : a wrapper around dockerfiles

## Getting started

To run installation in a docker, use the following command:
```
./start_docker.sh <arch> [interactive]
```
Example :
```
./start_docker archlinux
```
will install Repetier in a clean Archlinux environment. If you prefer to run installation step by step (i.e. not autostarting installation at docker spawning), you can add the ```interactive``` parameter :
```
./start_docker archlinux interactive
```

## Authors
* **Alexis Lothoré** - *Initial Docker import*
