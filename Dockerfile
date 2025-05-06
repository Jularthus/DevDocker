FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

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
  nasm \
  && apt-get clean

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

WORKDIR /app

COPY . /app
COPY ./zshrc /root/.zshrc  
COPY ./bigpathgreen.zsh-theme /root/.oh-my-zsh/custom/themes/

CMD ["/bin/zsh"]
