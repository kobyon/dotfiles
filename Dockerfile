FROM archlinux:base-devel

# Build arguments for user configuration
ARG USERNAME=ctrl
ARG USER_UID=1000
ARG USER_GID=1000

# Update system
RUN pacman -Syu --noconfirm

# Install base packages
RUN pacman -S --noconfirm \
    zsh \
    zsh-completions \
    git \
    rust \
    openssh \
    curl \
    jq \
    python \
    docker \
    sudo

# Create user with specified UID/GID
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID --shell /usr/bin/zsh --create-home $USERNAME

# Add user to docker group (created by docker package)
# Note: GID will be adjusted at runtime by bootstrap script to match host's docker.sock
RUN usermod -aG docker $USERNAME

# Configure sudo
RUN printf '%s\n' "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    visudo -cf /etc/sudoers.d/$USERNAME

# Copy scripts and dotfiles
COPY --chmod=0755 entrypoint /usr/local/bin/sakkenix-entrypoint
COPY --chmod=0755 bootstrap /usr/local/bin/sakkenix-bootstrap
COPY --chown=$USERNAME:$USERNAME home /home/$USERNAME

# Create projects directory for sub-containers to mount/use
RUN mkdir -p /home/$USERNAME/projects && \
    chown $USERNAME:$USERNAME /home/$USERNAME/projects

# Container defaults
USER $USERNAME
WORKDIR /home/$USERNAME
SHELL ["/usr/bin/zsh", "-c"]
ENTRYPOINT ["/usr/local/bin/sakkenix-entrypoint"]
CMD ["/usr/bin/zsh", "-l"]
