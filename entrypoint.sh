#!/bin/bash

ARTIQ_ENV="base"

function init_artiq_env {
  source activate $ARTIQ_ENV
}

# ---------------------------------------------------------------------------------------------------------------------
# Fail on error

set -e

# ---------------------------------------------------------------------------------------------------------------------
# Process arguments

while [ 1 ]; do 
    case $1 in
      "--uid")
          shift
          HOST_UID="$1"
          shift
          ;;
      "--user")
          shift
          HOST_USER="$1"
          shift
          ;;
      "--gid")
          shift
          HOST_GID="$1"
          shift
          ;;
      "--group")
          shift
          HOST_GROUP="$1"
          shift
          ;;

      *)
          break
          ;;
    esac
done

# ---------------------------------------------------------------------------------------------------------------------
# Install packages, if external sources are used

if [ -d /migen ]; then
  (init_artiq_env; cd /migen; pip install -e .; chmod 755 -R /opt/conda/lib/python3.5/site-packages)
fi

if [ -d /misoc ]; then
  (init_artiq_env; cd /misoc; pip install -e .; chmod 755 -R /opt/conda/lib/python3.5/site-packages)
fi

if [ -d /artiq ]; then
  (init_artiq_env; cd /artiq; pip install -e .; chmod 755 -R /opt/conda/lib/python3.5/site-packages)
fi

# ---------------------------------------------------------------------------------------------------------------------
# Create user if not root

if [ "$HOST_USER" != "root" ]; then
  groupadd --gid "${HOST_GID}" "${HOST_GROUP}"
  useradd --gid "${HOST_GID}" --uid "${HOST_UID}" --home-dir /home/workspace --no-create-home "${HOST_USER}"
fi

# ---------------------------------------------------------------------------------------------------------------------
# Start command or console

# No additional arguments supplied mean start console
if [ "$1" == "" ]; then
  exec gosu "${HOST_USER}" /bin/bash --rcfile /.bashrc -i
# Otherwise execute supplied arguments
else
  init_artiq_env
  exec gosu "${HOST_USER}" /bin/bash -c "source /.bashrc && $@"
fi
