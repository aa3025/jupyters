FROM debian

########## edit this section to change the username, UID/GID and passwd you like this container to run as ##############
ARG user=user
ARG uid=1000
ARG gid=1000
# user password in the container
ARG pass=qwerty
# user python venv name to create (see also line 36)
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
RUN echo "source /home/$user/$venv/bin/activate" >> /home/$user/.bashrc
RUN echo ". ~/.bashrc" >> /home/$user/.bash_profile
RUN chown -R $user:$user /home/$user
EXPOSE 8888
USER $user
RUN /opt/miniconda3/bin/python3 -m venv /home/$user/$venv
COPY requirements.txt .
RUN . /home/$user/$venv/bin/activate && pip install -r requirements.txt
RUN . /home/$user/$venv/bin/activate && pip install jupyterlab ipykernel
     
# any extra packages:
RUN . /home/$user/$venv/bin/activate && pip install jupyterlab ipykernel matplotlib
# kernel for jupyter
RUN . /home/$user/$venv/bin/activate && python -m ipykernel install --user --name=$venv

CMD "/bin/bash"
# build as e.g. "docker build . -t my/image_pip:last"
