FROM ubuntu:22.04

# Install base dependencies
RUN apt-get update && apt-get install -y \
    git curl python3-pip ripgrep fd-find xz-utils \
    fuse libfuse2 build-essential --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g neovim

# Install Neovim 0.9.5
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz \
    && tar xzf nvim-linux64.tar.gz \
    && mv nvim-linux64/bin/nvim /usr/local/bin/ \
    && rm -rf nvim-linux64*

# Install Python provider
RUN python3 -m pip install pynvim

# Create config structure
RUN mkdir -p /root/.config/nvim

# Clone config with forced clean install
ARG NEOVIM_CONFIG_REPO="https://github.com/ColtNovak/HeaVim-nvim.git"
RUN git clone --depth 1 "$NEOVIM_CONFIG_REPO" /root/.config/nvim \
    && rm -rf /root/.config/nvim/.git

# Pre-install plugins
RUN nvim --headless "+Lazy! sync" +qa

# Install ttyd
RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

# Verify versions
RUN node --version && npm --version && nvim --version

WORKDIR /workspace
CMD ["ttyd", "-p", "8080", "nvim"]
