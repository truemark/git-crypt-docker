FROM debian:bullseye AS build
COPY --from=truemark/git:debian-bullseye /usr/local/ /usr/local/
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -qq make g++ libssl-dev libcurl4
ARG GIT_CRYPT_VERSION
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN cd /git-crypt && \
    make && \
    rm -rf /usr/local/* && \
    make install && \
    strip /usr/local/bin/git-crypt

FROM debian:bullseye as test
COPY --from=truemark/git:debian-bullseye /usr/local/ /usr/local/
COPY --from=build /usr/local/bin/git-crypt /usr/local/bin/git-crypt
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qq libcurl4
COPY test.sh /test.sh
RUN /test.sh

FROM scratch
COPY --from=test /usr/local/bin/git-crypt /usr/local/bin/git-crypt
