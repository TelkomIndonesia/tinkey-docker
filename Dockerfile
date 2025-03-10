ARG VERSION=1.10.1



FROM alpine AS downloader
ARG VERSION
WORKDIR /src
RUN apk add --no-cache tar curl
RUN curl -L https://storage.googleapis.com/tinkey/tinkey-${VERSION}.tar.gz \
    |  tar xvz -C .



FROM gcr.io/distroless/java17-debian12:debug
COPY --from=downloader /src/tinkey_deploy.jar /usr/bin/tinkey_deploy.jar
COPY ./tinkey /usr/bin/tinkey
ENTRYPOINT ["tinkey"]
