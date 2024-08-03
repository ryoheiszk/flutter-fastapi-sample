FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-8-jdk \
    wget \
    && apt-get clean

# Set up new user
RUN useradd -ms /bin/bash developer

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable /home/developer/flutter

# Add flutter to PATH
ENV PATH="/home/developer/flutter/bin:${PATH}"

# Create app directory and set permissions
RUN mkdir /app && chown -R developer:developer /app /home/developer/flutter

# Switch to developer user
USER developer

# Set working directory
WORKDIR /app

# Run basic check to download Dart SDK
RUN flutter doctor

# Enable flutter web
RUN flutter config --enable-web

# Copy the app files to the container
COPY --chown=developer:developer . .

# Get app dependencies
RUN flutter pub get

# Build the app for the web
RUN flutter build web

# Set the server startup command
CMD ["flutter", "run", "-d", "web-server", "--web-port", "3000", "--web-hostname", "0.0.0.0"]
