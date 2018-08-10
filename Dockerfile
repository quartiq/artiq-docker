FROM continuumio/miniconda3:latest

RUN conda install -qy \
	-c m-labs/label/dev -c m-labs -c defaults -c conda-forge \
	nomkl artiq && \
	conda clean -tipsy

# Install stuff necessery for Xilinx Vivado and X apps
RUN apt-get update && apt-get install -y \
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

RUN echo 'source activate base && cd ~/' >> /.bashrc
ADD entrypoint.sh /entrypoint.sh

# We'll be acting as an ordinary user, so to enable experiments with packages
# let's delete root password.
RUN passwd -d root

ENTRYPOINT [ "/entrypoint.sh" ]

