# jupyters

Dockerfile for creating a container with miniconda3 based python3 and user environment "jup" for launching jupyter lab.

To build the image, pull this repository

`git clone https://github.com/aa3025/jupyters.git`

cd jupyters

If necessary edit the 1st sectiopn of the Dockerfile, to change user data: UID/GID, username and password.

`docker build . -t username/mypythonimage:latest`

Once image build process complete, edit the ### params ### section of the container startup script "startdocker.sh" and execute it: 

`sh ./startdocker.sh`
