# Use an official Python image that matches your system's architecture
FROM python:3.10

# Set environment variables
ENV PYTHONUNBUFFERED=1
# ENV VIRTUAL_ENV=/home/venv
# ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Set working directory inside the container
WORKDIR /app

# Install necessary system dependencies and PostgreSQL client
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    vim \
    nano \
    net-tools \
    postgresql-client \
    iputils-ping
    #&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt file to the container
COPY requirements.txt .

# Create venv in an isolated directory (e.g., /venvs/jupyter-venv)
RUN mkdir -p /venvs && \
    python3 -m venv /venvs/jupyter-venv && \
    /venvs/jupyter-venv/bin/pip install --upgrade pip

RUN /venvs/jupyter-venv/bin/pip install -r requirements.txt

# Expose necessary ports for Gradio, Flask, Jupyter, and PostgreSQL
EXPOSE 8778 5000

# Set default command to start a shell, allowing flexibility
CMD ["bash"]
