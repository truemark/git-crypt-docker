FROM alpine:latest AS git-build
ARG GIT_CRYPT_VERSION
RUN apk update && apk add git make g++ openssl-dev openssl1.1-compat
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN rm -rf /usr/local/* && \
    cd /git-crypt && \
    # See https://github.com/AGWA/git-crypt/issues/232
    CXXFLAGS='-DOPENSSL_API_COMPAT=0x30000000L' make && \
    make install && \
    strip /usr/local/bin/git-crypt

FROM scratch
COPY --from=git-build /usr/local/ /usr/local/
