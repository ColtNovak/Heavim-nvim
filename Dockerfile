FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git \
    curl \
    neovim \
    lua5.3 \
    luarocks \
    python3-pip \
    nodejs \
    npm \
    ripgrep \
    fd-find

RUN python3 -m pip install pynvim && \
    npm install -g neovim

ARG NEOVIM_CONFIG_REPO
RUN git clone $NEOVIM_CONFIG_REPO /root/.config/nvim

RUN mkdir -p /workspace
WORKDIR /workspace

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

CMD ["ttyd", "-p", "8080", "nvim"]
