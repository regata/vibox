FROM debian:trixie-slim

# if you change this, review .devcontainer/devcontainer.json
ARG USER=agent

# Claude IDE integration needs `ps -p` command which is installed via procps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        procps \
        ca-certificates \
        curl \
        git \
        python3 \
        sudo \
    && apt-get clean

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# setup user
RUN groupadd -r $USER \
    && useradd -ms /bin/bash -g $USER -G sudo $USER
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R $USER /home/$USER/

USER $USER
ENV HOME=/home/$USER
WORKDIR /home/$USER/vibox

# RUN curl -fsSL https://claude.ai/install.sh | bash
# ENV CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
ENV PATH=$HOME/.local/bin:$PATH

# Install Codex
RUN curl -fsSL https://chatgpt.com/codex/install.sh | bash
ENV VISUAL="code --wait"
