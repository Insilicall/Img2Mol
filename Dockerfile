FROM python:3.8.5

# Create app directory
WORKDIR /app

# Bundle app source
COPY . .

# Download Model Weights
RUN bash download_model.sh

# Install dependencies
RUN pip install .