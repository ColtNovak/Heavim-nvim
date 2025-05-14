FROM ubuntu:22.04 as builder

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-pip \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    unzip \
    luarocks \
    lua5.3 \
    liblua5.3-dev

RUN python3 -m pip install --user pynvim
RUN npm install -g neovim

RUN git clone https://github.com/ColtNovak/Heavim-nvim /tmp/nvim-config

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    neovim \
    git \
    python3 \
    nodejs \
    curl \
    lua5.3 \
    ripgrep \
    fd-find \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

# Copy installed components from builder
COPY --from=builder /root/.local /root/.local
COPY --from=builder /usr/lib/node_modules /usr/lib/node_modules
COPY --from=builder /tmp/nvim-config /root/.config/nvim

RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

ENV PATH="/root/.local/bin:/usr/lib/node_modules/bin:${PATH}"
ENV LUA_PATH="/usr/local/share/lua/5.3/?.lua;/usr/local/lib/lua/5.3/?.lua;;"
ENV LUA_CPATH="/usr/local/lib/lua/5.3/?.so;;"

RUN mkdir -p /workspace
VOLUME /workspace

HEALTHCHECK --interval=30s --timeout=10s \
    CMD curl -f http://localhost:8080/health || exit 1

EXPOSE 8080
CMD ["ttyd", "-p", "8080", "-t", "theme={ \"background\": \"#1a1b26\" }", "bash", "-c", "cd /workspace && nvim"]
