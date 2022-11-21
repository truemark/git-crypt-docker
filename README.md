# Git Crypt Docker

This project produces git-crypt binaries and docker images using sources located at
https://api.github.com/repos/AGWA/git-crypt with the following goals:

* Provide an easy way to get the latest version of git-crypt
* Provide linked versions of git-crypt that work with a number of distributions
* Provide amd64 and arm64 versions of git-crypt for Linux
* Reduce unwanted dependencies by not using a package manager

## How do I get the latest version of git-crypt into my docker image?

For Amazon Linux, add the following to your Dockerfile
```
COPY --from=truemark/git-crypt:amazonlinux /usr/local/ /usr/local/
```

For Alpine Linux, add the following to your Dockerfile
```
COPY --from=truemark/git-crypt:alpine /usr/local/ /usr/local/
```

For Ubuntu Jammy (22.04), add the following to your Dockerfile
```
COPY --from=truemark/git-crypt:ubuntu-jammy /usr/local/ /usr/local/
```

For Ubuntu Focal (20.04), add the following to your Dockerfile
```
COPY --from=truemark/git-crypt:ubuntu-focal /usr/local/ /usr/local/
```

## How do I download the latest version of git-crypt without using docker?

The following one-liner example uses curl, jq and tar to grab
the latest non-beta release for alpine-arm64 and installs it.

```
FLAVOR="alpine-arm64" curl -sSL $(curl -sSL https://api.github.com/repos/truemark/git-crypt-docker/releases/latest | jq -r "select(.tag_name | startswith(\"beta\") | not) | .assets[].browser_download_url | select(. | contains(\"${FLAVOR}\"))") -o - | tar -C / -zxf -
```

## Maintainers

- [erikrj](https://github.com/erikrj)

## License

The contents of this repository are released under the BSD 3-Clause license. See the
license [here](https://github.com/truemark/git-crypt-docker/blob/main/LICENSE.txt).


