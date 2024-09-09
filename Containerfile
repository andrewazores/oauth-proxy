ARG builder_version=8.10
ARG runner_version=8.10
ARG goversion=go1.22.6

FROM registry.access.redhat.com/ubi8/ubi:$builder_version AS builder
ARG goversion
COPY . .
RUN dnf install -y go \
    && go install golang.org/dl/$goversion@latest \
    && ~/go/bin/$goversion download \
    && ~/go/bin/$goversion build -a -v -x .

FROM registry.access.redhat.com/ubi8/ubi-minimal:$runner_version
COPY --from=builder ./oauth-proxy /usr/bin/oauth-proxy
ENTRYPOINT ["/usr/bin/oauth-proxy"]
