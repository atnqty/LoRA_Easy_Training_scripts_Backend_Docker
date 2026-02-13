#!/bin/bash
echo "Starting Stable Diffusion Trainer"

FORK=${FORK:-derrian-distro}
BRANCH=${BRANCH:-main}
PYVER=${PYVER:-3.10}

if [ ! -d "/trainer/$FORK" ] || [ ! "$(ls -A "/trainer/$FORK")" ]; then
  echo "Files not found, cloning..."
  mkdir -p /trainer/$FORK
  git clone https://github.com/$FORK/LoRA_Easy_Training_scripts_Backend.git /trainer/$FORK
  cd /trainer/$FORK
  git checkout $BRANCH
  git submodule update --init --recursive
  python$PYVER /trainer/$FORK/installer.py local
  chmod +x /trainer/$FORK/run.sh
  exec /trainer/$FORK/run.sh $ARGS
else
  echo "Files found, starting..."
  cd /trainer/$FORK
  git pull
  git checkout $BRANCH
  git submodule update --init --recursive
  chmod +x /trainer/$FORK/run.sh
  exec /trainer/$FORK/run.sh $ARGS
fi
