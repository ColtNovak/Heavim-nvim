FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    python3-pip \
    ripgrep \
    fd-find \
    xz-utils \
    fuse \
    libfuse2 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:zhangsongcui3371/fastfetch \
  apt update \
  apt install fastfetch*

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz && \
    tar xzf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64/bin/nvim /usr/local/bin/ && \
    mv nvim-linux-x86_64/lib/nvim /usr/local/lib/ && \
    mv nvim-linux-x86_64/share/nvim /usr/local/share/ && \
    rm -rf nvim-linux-x86_64*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install pynvim

RUN mkdir -p /root/.config/nvim
ARG NEOVIM_CONFIG_REPO="https://github.com/ColtNovak/HeaVim-nvim.git"
RUN git clone --depth 1 "$NEOVIM_CONFIG_REPO" /root/.config/nvim && \
    rm -rf /root/.config/nvim/.git

RUN nvim --headless "+Lazy! sync" +qa || \
    nvim --headless "+Lazy! sync" +qa

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

RUN node --version && \
    npm --version && \
    nvim --version

WORKDIR /workspace
CMD ["ttyd", "-p", "8080", "nvim"]
