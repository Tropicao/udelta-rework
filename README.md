# Repetier setup for uDelta Rework

## What is it ?
This repository contains necessary files to install Repetier for [Emotion Tech printer uDelta rework](https://www.reprap-france.com/produit/1234568619-imprimante-3d-microdelta-rework) on Linux. The software comes with full Repetier software and uDelta configuration for common slicers. This repository is only an update to the archive provided by Emotion Tech website, to ease Repetier installation

## How to install it ?
* Clone the repository
* In the freshly cloned repository, execute configureFirst.sh


After that, you have a link in /usr/bin so you can start the host from
everywhere with ```repetierHost```

## Something is broken ?
Please feel free to report any issue opening a Github issue section of this project

## Known issues
- You may see an OpenGL warning at startup. Ignore it.
- Sometimes the start fails. Just start again.
- Some mono versions seem to crash on exit. Ignore the messages as you are already leaving.
- You need a recent mono version like 3.2 or the host will crash sooner or later due to
  not implemented functions.
