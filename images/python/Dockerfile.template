FROM ubuntu:21.04 as asdf-base
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


FROM asdf-base as asdf-builder
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update                                \
    && apt install -y --no-install-recommends \
           build-essential                    \
           coreutils                          \
           dirmngr                            \
           gpg                                \
           libbz2-dev                         \
           libffi-dev                         \
           liblzma-dev                        \
           libncurses5-dev                    \
           libreadline-dev                    \
           libsqlite3-dev                     \
           libssl-dev                         \
           libxml2-dev                        \
           libxmlsec1-dev                     \
           libxtst6                           \
           llvm                               \
           locales                            \
           tk-dev                             \
           xz-utils                           \
           zlib1g-dev                         \
    && apt-get clean                          \
    && apt-get autoremove -y                  \
    && rm -rf /var/lib/apt/lists/*


FROM asdf-builder as asdf-python
ARG DEBIAN_FRONTEND=noninteractive
RUN sed -e '/^# deb/ s/# //' -i /etc/apt/sources.list                                 \
    && apt-get update                                                                 \
    && apt build-dep -o APT::Get::Build-Dep-Automatic=true -y --no-install-recommends \
           python3                                                                    \
    && asdf plugin-add python                                                         \
    && asdf install    python latest                                                  \
    && asdf global     python latest                                                  \
    && asdf install    python latest:3.8                                              \
    && apt-get clean                                                                  \
    && apt-get autoremove -y                                                          \
    && rm -rf /var/lib/apt/lists/*


FROM asdf-builder as asdf-nodejs
RUN asdf plugin-add nodejs           \
    && asdf install nodejs latest:16 \
    && asdf global  nodejs $(asdf latest nodejs 16)


FROM asdf-builder as asdf-golang
RUN asdf plugin-add golang        \
    && asdf install golang latest \
    && asdf global  golang latest


FROM asdf-builder as asdf-ruby
RUN asdf plugin-add ruby        \
    && asdf install ruby latest \
    && asdf global  ruby latest


FROM asdf-builder as asdf-java
RUN    asdf plugin-add java                                     \
    && asdf install    java latest:adoptopenjdk-11              \
    && asdf global     java $(asdf latest java adoptopenjdk-11)
    # && asdf plugin-add ant           \
    # && asdf install    ant  latest   \
    # && asdf global     ant  latest   \
    # && asdf plugin-add maven         \
    # && asdf install    maven latest  \
    # && asdf global     maven latest  \
    # && asdf plugin-add gradle        \
    # && asdf install    gradle latest \
    # && asdf global     gradle latest \


# FROM asdf-builder as asdf-direnv
# RUN asdf plugin-add direnv        \
#     && asdf install    direnv latest \
#     && asdf global     direnv latest \


FROM asdf-builder as asdf-adr-tools
RUN asdf plugin-add adr-tools        \
    && asdf install adr-tools latest \
    && asdf global  adr-tools latest


FROM ubuntu:21.04
ENV ASDF_DIR "/asdf"
ENV ASDF_DATA_DIR $ASDF_DIR
ENV PATH $ASDF_DIR/shims:$ASDF_DIR/bin:$PATH
COPY --from=asdf-base      /asdf                    /asdf
COPY --from=asdf-python    /asdf/plugins/python     /asdf/plugins/python
COPY --from=asdf-python    /asdf/installs/python    /asdf/installs/python
COPY --from=asdf-python    /root/.tool-versions     /root/.tool-versions-python
COPY --from=asdf-nodejs    /asdf/plugins/nodejs     /asdf/plugins/nodejs
COPY --from=asdf-nodejs    /asdf/installs/nodejs    /asdf/installs/nodejs
COPY --from=asdf-nodejs    /root/.tool-versions     /root/.tool-versions-nodejs
COPY --from=asdf-golang    /asdf/plugins/golang     /asdf/plugins/golang
COPY --from=asdf-golang    /asdf/installs/golang    /asdf/installs/golang
COPY --from=asdf-golang    /root/.tool-versions     /root/.tool-versions-golang
COPY --from=asdf-ruby      /asdf/plugins/ruby       /asdf/plugins/ruby
COPY --from=asdf-ruby      /asdf/installs/ruby      /asdf/installs/ruby
COPY --from=asdf-ruby      /root/.tool-versions     /root/.tool-versions-ruby
COPY --from=asdf-java      /asdf/plugins/java       /asdf/plugins/java
COPY --from=asdf-java      /asdf/installs/java      /asdf/installs/java
# COPY --from=asdf-java      /asdf/plugins/ant        /asdf/plugins/ant
# COPY --from=asdf-java      /asdf/installs/ant       /asdf/installs/ant
COPY --from=asdf-java      /root/.tool-versions     /root/.tool-versions-java
COPY --from=asdf-adr-tools /asdf/plugins/adr-tools  /asdf/plugins/adr-tools
COPY --from=asdf-adr-tools /asdf/installs/adr-tools /asdf/installs/adr-tools
COPY --from=asdf-adr-tools /root/.tool-versions     /root/.tool-versions-adr-tools
RUN cat /root/.tool-versions-* > /root/.tool-versions \
    && rm -f /root/.tool-versions-* \
    && asdf reshim
CMD ["asdf"]
