#!/bin/bash
echo "Starting Stable Diffusion Trainer"

FORK=${FORK:-derrian-distro}
BRANCH=${BRANCH:-main}

if [ ! -d "/trainer/$FORK" ] || [ ! "$(ls -A "/trainer/$FORK")" ]; then
  echo "Files not found, cloning..."
  mkdir -p /trainer/$FORK
  git clone https://github.com/$FORK/LoRA_Easy_Training_scripts_Backend.git /trainer/$FORK
  cd /trainer/$FORK
  git checkout $BRANCH
  python3.10 /trainer/$FORK/installer.py local
  chmod +x /trainer/$FORK/run.sh
  exec /trainer/$FORK/run.sh $ARGS
else
  echo "Files found, starting..."
  cd /trainer/$FORK
  git pull
  git checkout $BRANCH
  chmod +x /trainer/$FORK/run.sh
  exec /trainer/$FORK/run.sh $ARGS
fi
