#!/bin/bash

ARTIQ_ENV="artiq-dev"

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
# Copy is made to allow RO mounts of external sources

FIX_PERMISSIONS=0

if [ -d /migen_ext ]; then
  (init_artiq_env; rsync -a /migen_ext/* /tmp/migen; cd /tmp/migen; pip install -e .)
fi

if [ -d /misoc_ext ]; then
  (init_artiq_env; rsync -a /misoc_ext/* /tmp/misoc; cd /tmp/misoc; pip install -e .)
fi

if [ -d /artiq_ext ]; then
  (init_artiq_env; rsync -a /artiq_ext/* /tmp/artiq; cd /tmp/artiq; pip install -e .)
fi

echo "cd /workspace" >> /.bashrc

# ---------------------------------------------------------------------------------------------------------------------
# Create user if not root

if [ "$HOST_USER" != "root" ]; then
  groupadd --gid $HOST_GID $HOST_GROUP
  useradd --gid $HOST_GID --uid $HOST_UID --home-dir /home/user $HOST_USER
  chown -R $HOST_UID:$HOST_GID /home/user
fi

# ---------------------------------------------------------------------------------------------------------------------
# Start command or console


# No additional arguments supplied mean start console
if [ "$1" == "" ]; then
  exec gosu $HOST_USER /bin/bash --rcfile /.bashrc -i
# Otherwise execute supplied arguments
else
  init_artiq_env
  exec gosu $HOST_USER /bin/bash -c "source /.bashrc && $@"
fi
