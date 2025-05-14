FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git curl python3-pip ripgrep fd-find fastfetch \
    fuse libfuse2 xz-utils --no-install-recommends \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz \
    && tar xzf nvim-linux64.tar.gz \
    && mv nvim-linux64/bin/nvim /usr/local/bin/ \
    && rm -rf nvim-linux64*

RUN python3 -m pip install --no-cache-dir pynvim \
    && npm install -g neovim

RUN mkdir -p /root/.config/nvim

ARG NEOVIM_CONFIG_REPO="https://github.com/ColtNovak/HeaVim-nvim.git"
RUN git clone --depth 1 "$NEOVIM_CONFIG_REPO" /root/.config/nvim \
    && rm -rf /root/.config/nvim/.git

RUN nvim --headless "+Lazy! sync" +qa

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

RUN node --version && npm --version && nvim --version && fastfetch --version

WORKDIR /workspace
CMD ["ttyd", "-p", "8080", "nvim"]
