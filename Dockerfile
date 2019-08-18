# We will use Ubuntu for our image
# FROM continuumio/anaconda3:latest
FROM ebitraining/mexicobiobank

USER root

# # # Add sudo
RUN apt-get -y install sudo

# # # Add user hdruk with no password, add to sudo group
RUN adduser --home /home/hdruk --disabled-password --gecos '' hdruk
RUN adduser hdruk sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# # Adding wget and bzip2 and python and pip
RUN apt-get install -y python3
RUN wget https://bootstrap.pypa.io/get-pip.py && sudo python3.6 get-pip.py
RUN pip install jupyter
RUN pip install sklearn numpy pandas seaborn graphviz imblearn




USER hdruk
WORKDIR /home/hdruk/
RUN chmod a+rwx /home/hdruk/
#RUN sudo usermod -m -d /home/hdruk hdruk
#RUN setenv HOME /home/hdruk
RUN echo "export HOME=/home/hdruk/" >> /home/hdruk/.bashrc
ENV HOME=/home/hdruk/

RUN echo `env` | grep HOME

RUN git clone https://github.com/athro/hdruk_summerschool_session_1_2.git
RUN cp -r /home/hdruk/hdruk_summerschool_session_1_2/python /home/hdruk/
RUN cd /home/hdruk/python/ && wget "https://drive.google.com/uc?export=download&id=1q5L74_joy4LXyMiNZbUA6IdYnfgEoFTp" -O session1_data.tgz && tar xvfz session1_data.tgz

# RUN sudo su && apt-get update && apt-get install -y --no-install-recommends apt-utils
# RUN sudo su && apt-get install -y emacs
#RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
#RUN apt-get install -y emacs

# Updating Ubuntu packages
# RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
# RUN apt-get update && yes|apt-get upgrade





