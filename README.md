# jupyters

This repository provides the Dockerfile and accompanying scripts for creating a docker container with miniconda3 python and user environment "jupyterenv" for launching jupyter lab in a container. If you prefer, you can pull branch "pip", which solely using pip (no conda) for making venv and installing python packages. Branch "conda" (or master) uses conda for making user env, but also allows using pip obviously.

To build the image, pull this repository

`git clone https://github.com/aa3025/jupyters.git`

`cd jupyters`

If necessary edit the 1st section of the Dockerfile, to change user data: UID/GID, username and password as well as parameters section in `02_startdocker.sh` file

Then run:

`sh ./01_build_image.sh`

Once image build process complete, the `02_startdocker.sh` script is launched automatically.

If you want just to launch already existing image with IMAGEID built previously, do:

`sh ./02_startdocker.sh IMAGEID`
