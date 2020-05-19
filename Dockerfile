FROM nixos/nix

# Set a cache date, for easy updates
ARG CACHE_DATE=2020-05-19

RUN mkdir /artiq
WORKDIR /artiq

# Add nix channels from https://m-labs.hk/artiq/manual/installing.html#installing-via-nix-linux
RUN nix-channel --add https://nixbld.m-labs.hk/channel/custom/artiq/full/artiq-full
RUN nix-channel --remove nixpkgs
RUN nix-channel --add https://nixos.org/channels/nixos-19.09 nixpkgs
RUN nix-channel --update

# Copy nix security info and environment spec
COPY nix.conf /root/.config/nix/nix.conf
COPY artiq_env.nix .

# Get / build all the requirements once for the image
RUN nix-shell artiq_env.nix --command "artiq_client --version"

# Start an interactive shell on launch
ENTRYPOINT ["nix-shell", "artiq_env.nix"]

