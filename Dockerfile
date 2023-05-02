FROM continuumio/miniconda3
RUN apt-get -qq update && apt-get install curl -y

# Create app directory
WORKDIR /app

# Bundle app source
COPY . .

# Download Model Weights
RUN bash download_model.sh

# Installation
RUN conda env create -f environment.local-cddd.yml

# Make RUN commands use the new environment:
RUN echo "conda activate img2mol" >> ~/.bashrc
RUN echo "pip install ." >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

# The code to run when container is started:
ENTRYPOINT ["./entrypoint.sh"]