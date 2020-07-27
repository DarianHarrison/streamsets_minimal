ARG SDC_VERSION=3.16.1
FROM streamsets/datacollector:${SDC_VERSION}

# Copy the stage libs and enterprise stage libs
COPY --chown=admin:admin streamsets-libs ${SDC_DIST}/streamsets-libs

# Copy the custom sdc.properties file into the image
COPY --chown=admin:admin sdc-conf/ ${SDC_CONF}/