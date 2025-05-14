FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git \
    curl \
    lua5.3 \
    luarocks \
    python3-pip \
    neovim \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    fuse \
    libfuse2 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage \
    && chmod u+x nvim.appimage \
    && mv nvim.appimage /usr/local/bin/nvim

RUN python3 -m pip install pynvim \
    && npm install -g neovim

RUN mkdir -p /root/.config/nvim

ARG NEOVIM_CONFIG_REPO="https://github.com/ColtNovak/HeaVim-nvim.git"
RUN git clone "$NEOVIM_CONFIG_REPO" /tmp/nvim-config \
    && mv /tmp/nvim-config/* /root/.config/nvim/ \
    && mv /tmp/nvim-config/.* /root/.config/nvim/ 2>/dev/null || true \
    && rm -rf /tmp/nvim-config

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

RUN mkdir -p /workspace
WORKDIR /workspace

CMD ["ttyd", "-p", "8080", "nvim"]
