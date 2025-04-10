#!/bin/bash

# get the path to this script
THIS_PATH=$(dirname "$0")
REPO_PATH=$(cd "$THIS_PATH/../.." && pwd)
THIS_PATH=$(cd "$THIS_PATH" && pwd)
IMAGE_NAME="ros1_noetic"

apptainer build --fakeroot --fix-perms -F $REPO_PATH/images/$IMAGE_NAME.sif $THIS_PATH/recipe.def
apptainer build --fakeroot --sandbox $IMAGES_PATH/$IMAGE_NAME/ $IMAGES_PATH/$IMAGE_NAME.sif