FROM registry.access.redhat.com/ubi8/ubi:8.9 AS builder
RUN dnf install -y go
RUN go install golang.org/dl/go1.22rc1@latest && \
    ~/go/bin/go1.22rc1 download
COPY . .
RUN ~/go/bin/go1.22rc1 build -a -v -x .

FROM registry.access.redhat.com/ubi8/ubi-minimal:8.9
COPY --from=builder ./oauth-proxy /usr/bin/oauth-proxy
ENTRYPOINT ["/usr/bin/oauth-proxy"]
