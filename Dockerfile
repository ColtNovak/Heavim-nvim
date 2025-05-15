FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y \
    git curl python3-pip ripgrep fd-find \
    fuse libfuse2 xz-utils lua5.3 luarocks \
    build-essential --no-install-recommends && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz -o nvim-linux64.tar.gz && \
    tar xzf nvim-linux64.tar.gz && \
    cp -r nvim-linux64/bin/* /usr/bin/ && \
    cp -r nvim-linux64/lib/* /usr/lib/ && \
    cp -r nvim-linux64/share/* /usr/share/ && \
    rm -rf nvim-linux64*
RUN npm install -g neovim && \
    python3 -m pip install --no-cache-dir pynvim python-lsp-server[all]
RUN mkdir -p /root/.config/nvim && \
    git clone --depth 1 https://github.com/ColtNovak/HeaVim-nvim.git /root/.config/nvim && \
    rm -rf /root/.config/nvim/.git
RUN nvim --version && \
    nvim --headless -c "lua vim.notify('Neovim started successfully')" -c "q" && \
    nvim --headless "+Lazy sync" +qa || echo "Plugin installation will be completed on first run" && \
    nvim --headless "+MasonInstallAll" +qa || echo "Mason packages will be installed on first run"
RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd
WORKDIR /workspace
EXPOSE 8080
CMD ["ttyd", "-p", "8080", "nvim"]
