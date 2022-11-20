FROM amazonlinux:latest AS git-build
ARG GIT_CRYPT_VERSION
RUN yum install -q -y git make gcc-c++ openssl-devel zlib-devel
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN rm -rf /usr/local/* && \
    cd /git-crypt && \
    make && \
    make install && \
    strip /usr/local/bin/git-crypt

FROM scratch
COPY --from=git-build /usr/local/ /usr/local/
