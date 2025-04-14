# Use an official Ubuntu as a base image
FROM ubuntu:20.04

# Set environment variables to prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies: zsh, Oh My Zsh, and other required tools
RUN apt-get update && \
  apt-get install -y \
  build-essential \
  gcc \
  g++ \
  make \
  valgrind \
  git \
  zsh \
  curl \
  && apt-get clean

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Create a working directory inside the container
WORKDIR /app

# Copy your C code, Makefile, and custom Zsh config file into the container
COPY . /app
COPY .zshrc /root/.zshrc  
COPY ./bigpathgreen.zsh-theme /root/.oh-my-zsh/custom/themes/

# Set the default shell to zsh and run the shell
CMD ["/bin/zsh"]
