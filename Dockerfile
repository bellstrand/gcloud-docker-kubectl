FROM node:9.6-stretch

ENV CLOUD_SDK_VERSION 189.0.0

ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1

ENV PATH /google-cloud-sdk/bin:$PATH

RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --quiet components update && \
    gcloud --quiet components install kubectl && \
    gcloud --version

RUN curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose


VOLUME ["/root/.config"]