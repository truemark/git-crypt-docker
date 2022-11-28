FROM alpine:3.16 AS build
COPY --from=truemark/git:alpine-3.16 /usr/local/ /usr/local/
RUN apk add --no-cache make libcurl g++ openssl-dev libstdc++
ARG GIT_CRYPT_VERSION
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN cd /git-crypt && \
    make && \
    rm -rf /usr/local/* && \
    make install && \
    strip /usr/local/bin/git-crypt

FROM alpine:3.16 as test
COPY --from=truemark/git:alpine-3.16 /usr/local/ /usr/local/
COPY --from=build /usr/local/bin/git-crypt /usr/local/bin/git-crypt
COPY test.sh /test.sh
RUN apk add --no-cache bash libcurl libstdc++
RUN /test.sh

FROM scratch
COPY --from=test /usr/local/bin/git-crypt /usr/local/local/bin/git-crypt
