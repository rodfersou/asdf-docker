FROM rodfersou/asdf-builder:latest as base
ARG DEBIAN_FRONTEND=noninteractive
ENV ASDF_DIR "/asdf"
ENV ASDF_DATA_DIR $ASDF_DIR
ENV PATH $ASDF_DIR/shims:$ASDF_DIR/bin:/root/.local/bin:$PATH
ENV XDG_CACHE_HOME="/cache"
ENV PIP_CACHE_DIR="/cache/pip"
ENV PIPX_HOME="/cache/pipx"
RUN sed -e '/^# deb/ s/# //' -i /etc/apt/sources.list                                 \
    && apt-get update                                                                 \
    && apt build-dep -o APT::Get::Build-Dep-Automatic=true -y --no-install-recommends \
           python3                                                                    \
    && asdf plugin-add python                                                         \
    && asdf install    python latest:3.10                                             \
    && asdf global     python $(asdf latest python 3.10)                              \
    && asdf reshim                                                                    \
    && pip install --user asdf --upgrade                                              \
           pip                                                                        \
           setuptools                                                                 \
           wheel                                                                      \
    && pip install --user asdf                                                        \
           pipx                                                                       \
           ipdb                                                                       \
           debug                                                                      \
    && asdf reshim                                                                    \
    && echo 'eval "$(register-python-argcomplete pipx)"' >> /root/.bashrc             \
    && pipx install poetry                                                            \
    && pipx install pipenv                                                            \
    && pipx install pdm || true                                                       \
    && pipx install ipython                                                           \
    && apt-get clean                                                                  \
    && apt-get autoremove -y                                                          \
    && rm -rf /var/lib/apt/lists/*


FROM ubuntu:21.04
ENV LC_CTYPE=C.UTF-8
ENV ASDF_DIR "/asdf"
ENV ASDF_DATA_DIR $ASDF_DIR
ENV PATH $ASDF_DIR/shims:$ASDF_DIR/bin:/root/.local/bin:$PATH
ENV XDG_CACHE_HOME="/cache"
ENV PIP_CACHE_DIR="/cache/pip"
ENV PIPX_HOME="/cache/pipx"
ENV PIPENV_CACHE_DIR="/cache/pipenv"
ENV PIPENV_IGNORE_VIRTUALENVS=1
ENV PIPENV_VERBOSITY=-1
ENV POETRY_CACHE_DIR=/cache/poetry
ENV POETRY_VIRTUALENVS_PATH=/cache/poetry_venvs
COPY --from=rodfersou/asdf-base:latest /asdf                 /asdf
COPY --from=base                       /asdf/plugins/python  /asdf/plugins/python
COPY --from=base                       /asdf/installs/python /asdf/installs/python
COPY --from=base                       /root/.local          /root/.local
COPY --from=base                       /root/.bashrc         /root/.bashrc
COPY --from=base                       /root/.tool-versions  /root/.tool-versions
COPY --from=base                       /cache                /cache
RUN asdf reshim
CMD ["ipython"]
