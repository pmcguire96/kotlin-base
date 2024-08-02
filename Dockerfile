FROM openjdk:21

ARG RUNTIME_CONNECTOR_VERSION=v2.5.2
ARG USERNAME=nonroot
ARG USER_UID=1000
ARG USER_GID=$USER_UID

USER root

ADD build/distributions/kotlin-base.tar /
ADD entrypoint.sh /

# RUN curl -sk "https://com/artifactory/platform/runtime-connector/${RUNTIME_CONNECTOR_VERSION}/runtime-connector-linux-amd64-${RUNTIME_CONNECTOR_VERSION}.tgz" -o /runtime-connector.tgz \
#     && tar xvzf /runtime-connector.tgz -C / \
#     && rm /runtime-connector.tgz \
#     && groupadd --gid $USER_GID $USERNAME \
#     && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
#     && mkdir -p /tap \
#     && chown -R $USERNAME:$USERNAME /tap \
#     && chmod +x /entrypoint.sh

USER nonroot

ENV APP=kotlin-base

ENTRYPOINT ["/runtime-connector", "--", "/entrypoint.sh"]
