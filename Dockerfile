FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    build-essential \
    curl \
    git \
    gnupg2 \
    wget \
    busybox \
    python3 \
    python3-dev \
    python3-pip \
    python3-lxml \
    pv \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Set the locale to avoid locale related issues
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Install Python packages
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . /app

CMD ["python3", "bot.py"]
