FROM rodfersou/asdf-base:latest
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
CMD ["asdf"]
