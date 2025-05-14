FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git curl python3-pip ripgrep fd-find \
    fuse libfuse2 xz-utils lua5.3 luarocks \
    build-essential cmake pkg-config --no-install-recommends \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/fastfetch-cli/fastfetch.git /tmp/fastfetch \
    && mkdir -p /tmp/fastfetch/build \
    && cd /tmp/fastfetch/build \
    && cmake .. \
    && cmake --build . --target fastfetch -j$(nproc) \
    && cmake --install . \
    && rm -rf /tmp/fastfetch

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz \
    && tar xzf nvim-linux64.tar.gz \
    && mv nvim-linux64/bin/nvim /usr/local/bin/ \
    && rm -rf nvim-linux64*

RUN npm install -g neovim typescript-language-server \
    vscode-langservers-extracted @tailwindcss/language-server \
    && python3 -m pip install pynvim python-lsp-server[all]

RUN mkdir -p /root/.config/nvim \
    && git clone --depth 1 https://github.com/ColtNovak/HeaVim-nvim.git /root/.config/nvim \
    && rm -rf /root/.config/nvim/.git

RUN nvim --headless "+Lazy sync" +qa \
    && nvim --headless "+MasonInstallAll" +qa

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

WORKDIR /workspace
CMD ["ttyd", "-p", "8080", "nvim"]
