FROM archlinux:base-devel

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm \
    zsh \
    zsh-completions

RUN useradd --no-create-home \
    --shell /usr/bin/zsh \
    ctrl

COPY --chown=ctrl:ctrl home /home/ctrl

USER ctrl
WORKDIR /home/ctrl
CMD ["/usr/bin/zsh"]
