FROM debian:trixie-slim

# if you change this, review .devcontainer/devcontainer.json
ARG NAME=vibox

# Claude IDE integration needs `ps -p` command which is installed via procps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        procps \
        ca-certificates \
        curl \
        git \
    && apt-get clean

# setup user
RUN groupadd -r $NAME \
    && useradd -ms /bin/bash -g $NAME -G sudo $NAME
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R $NAME /home/$NAME/

USER $NAME
ENV HOME=/home/$NAME
WORKDIR /home/$NAME/$NAME

RUN curl -fsSL https://claude.ai/install.sh | bash
ENV CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
ENV PATH=$HOME/.local/bin:$PATH
