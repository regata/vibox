FROM debian:trixie-slim

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
RUN groupadd -r vibox \
    && useradd -ms /bin/bash -g vibox -G sudo vibox
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chown -R vibox /home/vibox/

USER vibox
ENV HOME=/home/vibox
WORKDIR /home/vibox/vibox

RUN curl -fsSL https://claude.ai/install.sh | bash
ENV CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
ENV PATH=$HOME/.local/bin:$PATH
