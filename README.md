# jupyters

Dockerfile and accompanying scripts for creating a container with miniconda3 based python3 and user environment "jup" for launching jupyter lab.

To build the image, pull this repository

`git clone https://github.com/aa3025/jupyters.git`

`cd jupyters`

If necessary edit the 1st section of the Dockerfile, to change user data: UID/GID, username and password and parameters section in `02_startdocker.sh` file

Then run:

`sh ./01_duild_image.sh`

Once image build process complete, the `02_startdocker.sh` script is launched automatically.

If you want just to launch already existing image build previously, do:

`sh ./02_startdocker.sh IMAGEID`
