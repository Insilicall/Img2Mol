#!/usr/bin/env bash

gURL=https://drive.google.com/file/d/1oyknOulq_j0w9kzOKKIHdTLo5HphT99h/view?usp=sharing
ggID='1oyknOulq_j0w9kzOKKIHdTLo5HphT99h'
ggURL='https://drive.google.com/uc?export=download'

curl -sc /tmp/gcokie "${ggURL}&id=${ggID}" >/dev/null
getcode="$(awk '/_warning_/ {print $NF}' /tmp/gcokie)"

FOLDER=/opt/conda/envs/img2mol/lib/python3.6/site-packages/cddd/data/default_model
if [ -d $FOLDER ]; then
    echo "$FOLDER exists."
else
    echo "$FOLDER does not exist."
    echo -e "Downloading from "$gURL"...\n"
    cmd='curl --insecure -C - -LOJb /tmp/gcokie "${ggURL}&confirm=${getcode}&id=${ggID}"'
    eval $cmd
    unzip default_model.zip -d '/opt/conda/envs/img2mol/lib/python3.6/site-packages/cddd/data/'
    rm default_model.zip
fi