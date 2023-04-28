FROM continuumio/miniconda3
RUN apt-get -qq update && apt-get install libxrender1 libarchive-dev build-essential git  liblapack-dev libblas-dev  gfortran curl  -y

# Create app directory
WORKDIR /app

# Bundle app source
COPY . .

# Download Model Weights
RUN bash download_model.sh

# Installation
RUN conda env create -f environment.local-cddd.yml
RUN conda activate img2mol
RUN pip install .