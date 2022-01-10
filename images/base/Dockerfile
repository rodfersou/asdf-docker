FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive
ENV ASDF_DIR "/asdf"
ENV ASDF_DATA_DIR $ASDF_DIR
ENV PATH $ASDF_DIR/shims:$ASDF_DIR/bin:$PATH
RUN apt update                                                 \
    && apt install -y --no-install-recommends                  \
           ca-certificates                                     \
           curl                                                \
           git                                                 \
           wget                                                \
    && git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR \
    && cd $ASDF_DIR                                            \
    && git checkout "$(git describe --abbrev=0 --tags)"        \
    && apt-get clean                                           \
    && apt-get autoremove -y                                   \
    && rm -rf /var/lib/apt/lists/*
CMD ["asdf"]
