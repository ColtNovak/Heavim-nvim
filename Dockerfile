FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git curl python3-pip ripgrep fd-find \
    fuse libfuse2 xz-utils lua5.3 luarocks \
    build-essential ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g --no-audit --no-fund neovim && \
    python3 -m pip install --no-cache-dir \
    pynvim \
    python-lsp-server[all]

RUN mkdir -p /root/.config/nvim && \
    git clone --depth 1 https://github.com/ColtNovak/HeaVim-nvim.git /root/.config/nvim && \
    rm -rf /root/.config/nvim/.git

RUN nvim --headless "+Lazy sync" +qa && \
    nvim --headless "+MasonInstallAll" +qa

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd && \
    ttyd --version

WORKDIR /workspace
CMD ["ttyd", "-p", "8080", "nvim"]

RUN node --version && \
    npm --version && \
    python3 --version && \
    nvim --version
