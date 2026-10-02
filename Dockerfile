FROM archlinux:base-devel

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm \
    zsh \
    zsh-completions \
    git \
    rust

RUN useradd --no-create-home \
    --shell /usr/bin/zsh \
    ctrl

COPY --chmod=0755 entrypoint /usr/local/bin/sakkenix-entrypoint
COPY --chmod=0755 bootstrap /usr/local/bin/sakkenix-bootstrap
COPY --chown=ctrl:ctrl home /home/ctrl

# Container defaults
USER ctrl
WORKDIR /home/ctrl
SHELL ["/usr/bin/zsh", "-c"]
ENTRYPOINT ["/usr/local/bin/sakkenix-entrypoint"]
CMD ["/usr/bin/zsh", "-l"]
