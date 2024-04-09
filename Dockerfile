FROM ghcr.io/peterkappelt/arm-gcc-docker:12.3.rel1

# copy NXP-specific addons to compiler
COPY ./libs/ /compiler/

# libncursesw5 is required for GDB to run
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y libncursesw5 ca-certificates zlib1g-dev

# ninja build tool
RUN DEBIAN_FRONTEND=noninteractive apt install -y ninja-build

# git for managing repos
RUN DEBIAN_FRONTEND=noninteractive apt install -y git

# GDB requires python3.8 for some reason, so install it
RUN mkdir /python_build
RUN wget https://www.python.org/ftp/python/3.8.17/Python-3.8.17.tgz -O /python_build/python.tgz
RUN tar xzvf /python_build/python.tgz -C /python_build
RUN bash -c 'cd /python_build/Python-3.8.17 && ./configure && make && make install'
RUN rm -r /python_build