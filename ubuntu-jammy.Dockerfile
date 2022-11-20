FROM ubuntu:jammy AS git-build
ARG GIT_CRYPT_VERSION
RUN apt-get -qq update && apt-get install -qq git make g++ libssl-dev
RUN cd / && git clone -c advice.detachedHead=false --single-branch --depth 1 --branch ${GIT_CRYPT_VERSION} https://github.com/AGWA/git-crypt.git
RUN rm -rf /usr/local/* && \
    git config --global user.email "365211+erikrj@users.noreply.github.com" && \
    git config --global user.name "Erik Jensen" && \
    cd /git-crypt && \
    git remote add other https://github.com/ffontaine/git-crypt.git && \
    git fetch other && \
    git cherry-pick c1cdc && \
    make && \
    make install && \
    strip /usr/local/bin/git-crypt

FROM scratch
COPY --from=git-build /usr/local/ /usr/local/
