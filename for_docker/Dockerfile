From ubuntu:19.04
ENV DOT_DIR /home/eiji
WORKDIR ${DOT_DIR}
ADD ./ ./
ENV ZPLUG_HOME ${DOT_DIR}/.zplug

RUN apt-get update && \
    apt-get install --yes \
    curl \
    git \
    neovim \
    sudo \
    zsh && \
    useradd -u 11003 -s /bin/zsh -m eiji -G sudo && \
    sed -i '/^eiji:.*$/d' /etc/shadow && \
    echo 'eiji:$6$E9dQABOz$wz4xgcG4dOL9qnGlt3AoP0NbjCA5MnyCODv4K19Z/bIz2o5jyL//qYianmLCU3Wv7mjN7M7DHpNUQJO1oTNSv/:17403:0:99999:7:::' >> /etc/shadow && \
    chown -R eiji:eiji ${DOT_DIR}

USER eiji
RUN git clone https://github.com/zplug/zplug ${ZPLUG_HOME} && zsh && \
    vim +slient +VimEnter +Enter +qall

CMD ["/bin/zsh"]
