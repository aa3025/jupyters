FROM debian

########## edit this section to change the username, UID/GID and passwd you like this container to run as ##############
ARG user=user
ARG uid=1000
ARG gid=1000
# user password in the container
ARG pass=qwerty
# user's pthon venv name to create
ARG venv=jupyterenv
########################################################################################################################

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install wget mc nano sudo 
# RUN apt -y install octave gnuplot libqt5gui5 # if you want to try octave kernel
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3
RUN groupadd -g $gid $user
RUN useradd -u $uid -g $gid $user -s /bin/bash
RUN mkdir -p /home/$user

RUN usermod -aG sudo $user
RUN echo $user:$pass | chpasswd

RUN echo "source /opt/miniconda3/bin/activate" >> /home/$user/.bashrc
RUN echo "conda activate $venv" >> /home/$user/.bashrc
RUN echo ". ~/.bashrc" >> /home/$user/.bash_profile
RUN chown -R $user:$user /home/$user
EXPOSE 8888
USER $user
RUN \
     /opt/miniconda3/bin/conda create -y -n $venv python=3.10
     
# SHELL does not seem to allow to put variables inside [ ] (passing $venv to it not possible?)
SHELL ["/opt/miniconda3/bin/conda", "run", "-n", "jupyterenv", "/bin/bash", "-c"]
RUN conda install -y jupyterlab ipykernel
RUN conda install -y -c conda-forge octave_kernel matplotlib
RUN python -m ipykernel install --user --name=$venv

CMD "/bin/bash"
# build as e.g. "docker build . -t my/image:last"
