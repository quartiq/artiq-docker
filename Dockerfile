FROM continuumio/miniconda3:latest

ARG CACHE_DATE_BASE=2020-05-18

RUN nix-channel --add https://nixbld.m-labs.hk/channel/custom/artiq/full/artiq-full
RUN nix-channel --remove nixpkgs
RUN nix-channel --add https://nixos.org/channels/nixos-19.09 nixpkgs
RUN nix-channel --update

COPY nix.conf ~/.config/nix/nix.conf
COPY artiq_env.nix .

ENTRYPOINT ["nix-shell" "artiq_env.nix"]
