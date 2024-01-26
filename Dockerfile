FROM golang:1-alpine as builder
RUN apk update && apk add make
WORKDIR /build
ADD . .
RUN make build

FROM alpine
COPY --from=builder /build/tg /bin/tg
RUN chmod +x /bin/tg
RUN bash scripts/run.heroku.sh

ENTRYPOINT ["/bin/tg"]
