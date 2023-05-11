FROM ubuntu

ARG user="user"
ARG uid=1000
ARG gid=1000
ARG pass=qwerty

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install wget mc nano sudo 
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
RUN sh Miniconda3-py310_23.3.1-0-Linux-x86_64.sh -b -p /opt/miniconda3
RUN groupadd -g $gid $user
RUN useradd -u $uid -g $gid $user -s /bin/bash
RUN mkdir -p /home/$user

RUN usermod -aG sudo $user
RUN echo $user:$pass | chpasswd

RUN echo "source /opt/miniconda3/bin/activate" >> /home/user/.bashrc
RUN echo "conda activate jup" >> /home/user/.bashrc
RUN chown -R $user:$user /home/$user
EXPOSE 8888
USER user
RUN \
     /opt/miniconda3/bin/conda create -y -n jup python=3.10
SHELL ["/opt/miniconda3/bin/conda", "run", "-n", "jup", "/bin/bash", "-c"]
RUN conda install -y jupyterlab ipykernel
RUN conda install -y -c conda-forge octave_kernel matplotlib
RUN python -m ipykernel install --user --name=jup

CMD "/bin/bash"
# build as "docker build . -t aa3025/python3_10:latest"
