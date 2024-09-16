ARG builder_version=9.4
ARG runner_version=9.4
ARG goversion=go1.22.7

FROM registry.access.redhat.com/ubi9/ubi:$builder_version AS builder
ARG goversion
COPY . .
RUN dnf install -y go \
    && go install golang.org/dl/$goversion@latest \
    && ~/go/bin/$goversion download \
    && ~/go/bin/$goversion build -a -v -x .

FROM registry.access.redhat.com/ubi9/ubi-minimal:$runner_version
COPY --from=builder ./oauth-proxy /usr/bin/oauth-proxy
ENTRYPOINT ["/usr/bin/oauth-proxy"]
