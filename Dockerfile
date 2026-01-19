FROM nixos/nix

RUN nix-channel --update

RUN nix-env -iA nixpkgs.gcc \
        nixpkgs.gnumake \
        nixpkgs.valgrind \
        nixpkgs.gitMinimal \
        nixpkgs.zsh \
        nixpkgs.curl \
        nixpkgs.nasm \
        nixpkgs.tree \
        nixpkgs.iproute2 \
        nixpkgs.bc \
        nixpkgs.vim \
        nixpkgs.criterion \
        nixpkgs.python312 \
        nixpkgs.python312Packages.virtualenv \
        nixpkgs.autoconf \
        nixpkgs.autoconf-archive \
        nixpkgs.gnused \
        nixpkgs.glibc

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

WORKDIR /app
COPY . /app

COPY ./zshrc /root/.zshrc  
COPY ./bigpathgreen.zsh-theme /root/.oh-my-zsh/custom/themes/

ENV PATH="/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"
CMD ["zsh"]
