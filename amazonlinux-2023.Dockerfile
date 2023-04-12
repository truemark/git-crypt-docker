FROM amazonlinux:2023 AS build
COPY --from=truemark/git:amazonlinux-2023 /usr/local/ /usr/local/
RUN yum install -q -y make gcc-c++ openssl-devel
ARG GIT_CRYPT_VERSION
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN cd /git-crypt && \
    git config --global user.email "365211+erikrj@users.noreply.github.com" && \
    git config --global user.name "Erik Jensen" && \
    git remote add other https://github.com/ffontaine/git-crypt.git && \
    git fetch other && \
    git cherry-pick c1cdc && \
    make && \
    rm -rf /usr/local/* && \
    make install && \
    strip /usr/local/bin/git-crypt

FROM amazonlinux:2023 as test
COPY --from=truemark/git:amazonlinux-2023 /usr/local/ /usr/local/
COPY --from=build /usr/local/bin/git-crypt /usr/local/bin/git-crypt
COPY test.sh /test.sh
RUN /test.sh

FROM scratch
COPY --from=test /usr/local/bin/git-crypt /usr/local/bin/git-crypt
