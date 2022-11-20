FROM ubuntu:focal AS git-build
ARG GIT_CRYPT_VERSION
RUN apt-get -qq update && apt-get install -qq git make g++ libssl-dev
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN rm -rf /usr/local/* && \
    cd /git-crypt && \
    make && \
    make install && \
    strip /usr/local/bin/git-crypt

FROM scratch
COPY --from=git-build /usr/local/ /usr/local/
