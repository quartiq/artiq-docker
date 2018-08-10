FROM continuumio/miniconda3:latest

RUN git clone --recursive https://github.com/m-labs/artiq /artiq
RUN cd artiq && conda env create -f conda/artiq-dev.yaml && rm -rf /opt/conda/pkgs/*

# Install stuff necessery for Xilinx Vivado and X apps
RUN apt-get update && apt-get install -y \
        build-essential \
        libusb-0.1-4 \
        libusb-1.0-0 \
        libusb-dev \
        gosu \
        bash-completion \
        libsm6 \
        libxi6 \
        libxrender1 \
        libxrandr2 \
        fontconfig \
        libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'source activate artiq-dev && cd ~/' >> /.bashrc
ADD entrypoint.sh /entrypoint.sh

# We'll be acting as an ordinary user, so to enable experiments with packages
# let's delete root password.
RUN passwd -d root

ENTRYPOINT [ "/entrypoint.sh" ]

