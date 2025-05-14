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

RUN mkdir -p /root/.config/nvim

ARG NEOVIM_CONFIG_REPO="https://github.com/ColtNovak/HeaVim-nvim.git"
RUN git clone "$NEOVIM_CONFIG_REPO" /tmp/nvim-config && \
    mv /tmp/nvim-config/* /root/.config/nvim/ && \
    mv /tmp/nvim-config/.* /root/.config/nvim/ 2>/dev/null || true && \
    rm -rf /tmp/nvim-config

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

RUN mkdir -p /workspace
WORKDIR /workspace

CMD ["ttyd", "-p", "8080", "nvim"]
