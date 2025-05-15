

FROM ubuntu:22.04
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update && apt-get install -y \
    git curl python3-pip ripgrep neovim python-neovim \
    python3-neovim  fd-find xz-utils \
    fuse libfuse2 build-essential --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y nodejs 


RUN python3 -m pip install pynvim

RUN mkdir -p /root/.config/nvim

ARG NEOVIM_CONFIG_REPO="https://github.com/ColtNovak/HeaVim-nvim.git"
RUN git clone --depth 1 "$NEOVIM_CONFIG_REPO" /root/.config/nvim \
    && rm -rf /root/.config/nvim/.git

RUN nvim --headless "+Lazy! sync" +qa

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

# Verify versions
RUN node --version && npm --version && nvim --version

WORKDIR /workspace
CMD ["ttyd", "-p", "8080", "nvim"]
