FROM rodfersou/asdf-builder:latest as base
RUN asdf plugin-add nodejs           \
    && asdf install nodejs latest:14 \
    && asdf global  nodejs $(asdf latest nodejs 14)


FROM ubuntu:21.04
ENV ASDF_DIR "/asdf"
ENV ASDF_DATA_DIR $ASDF_DIR
ENV PATH $ASDF_DIR/shims:$ASDF_DIR/bin:$PATH
COPY --from=rodfersou/asdf-base:latest /asdf                 /asdf
COPY --from=base                       /asdf/plugins/nodejs  /asdf/plugins/nodejs
COPY --from=base                       /asdf/installs/nodejs /asdf/installs/nodejs
COPY --from=base                       /root/.tool-versions  /root/.tool-versions
RUN asdf reshim
CMD ["node"]
