ARG SDC_VERSION=3.16.1
FROM streamsets/datacollector:${SDC_VERSION}
ARG SDC_LIBS
RUN "${SDC_DIST}/bin/streamsets" stagelibs -install="${SDC_LIBS}"
COPY --chown=admin:admin resources/ ${SDC_RESOURCES}/
COPY --chown=admin:admin sdc-extras/ ${STREAMSETS_LIBRARIES_EXTRA_DIR}/