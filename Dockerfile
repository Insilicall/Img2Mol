FROM continuumio/miniconda3
RUN apt-get -qq update && apt-get install unzip curl -y

# Create app directory
WORKDIR /app

# Bundle app source
COPY . .

# Download Model Weights
RUN bash download_model.sh

# Installation
RUN conda env create -f environment.local-cddd.yml

# Download CDDD Model
RUN bash download_local_cddd.sh

# Make RUN commands use the new environment:
RUN echo "conda activate img2mol" >> ~/.bashrc
RUN echo "pip install ." >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

# Exposing only the web-api port
EXPOSE 4200

# The code to run when container is started:
ENTRYPOINT ["./entrypoint.sh"]