FROM ubuntu

# set up files
COPY ./src /home
RUN mkdir /home/data
WORKDIR /home

# required packages
RUN apt-get update
RUN apt-get install -y \
  dumb-init \
  iputils-ping

# start entrypoint.sh
# NOTE: entrypoint does not have to be an executable since bash is called explicitly
CMD ["dumb-init", "bash", "./entrypoint.sh"]
