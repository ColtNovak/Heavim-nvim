FROM archlinux:base-devel

RUN pacman -Syu --noconfirm --needed \
    git neovim nodejs npm python \
    bash ncurses util-linux xterm-terminfo \
    && rm -rf /var/cache/pacman/pkg/*

ENV TERM=xterm-256color
ENV SHELL=/bin/bash
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

RUN mkdir -p /root/.config/nvim
COPY init.lua /root/.config/nvim/

RUN nvim --headless "+Lazy sync" +qa 2>&1 | tee /tmp/nvim-install.log


RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/bin/ttyd \
    && chmod +x /usr/bin/ttyd

WORKDIR /workspace
CMD ["ttyd", "-p", "8080", "nvim"]
