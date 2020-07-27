ARG SDC_VERSION=3.16.1
FROM streamsets/datacollector:${SDC_VERSION}

# Copy the custom sdc.properties file into the image
COPY --chown=admin:admin sdc-conf/ sdc-conf/

# COPY --chown=admin:admin resources/ resources/
# COPY --chown=admin:admin sdc-extras/ sdc-extras/