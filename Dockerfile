# Use the official Python base image
FROM python:3.11-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter
RUN pip install notebook

# Set the working directory
WORKDIR /workspace

COPY calculator.ipynb .

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Start Jupyter Notebook server
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
