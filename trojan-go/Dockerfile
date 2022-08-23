# copied from https://github.com/p4gefau1t/trojan-go/blob/master/Dockerfile
FROM golang:alpine AS builder
WORKDIR /
ARG REF
RUN apk add git make &&\
    git clone https://github.com/p4gefau1t/trojan-go.git
RUN if [[ -z "${REF}" ]]; then \
        echo "No specific commit provided, use the latest one." \
    ;else \
        echo "Use commit ${REF}" &&\
        cd trojan-go &&\
        git checkout ${REF} \
    ;fi
RUN cd trojan-go &&\
    make &&\
    wget https://github.com/v2fly/domain-list-community/raw/release/dlc.dat -O build/geosite.dat &&\
    wget https://github.com/v2fly/geoip/raw/release/geoip.dat -O build/geoip.dat &&\
    wget https://github.com/v2fly/geoip/raw/release/geoip-only-cn-private.dat -O build/geoip-only-cn-private.dat

FROM alpine:3
ENV APP_NAME=dHJvamFuLWdv
WORKDIR /
RUN apk add --no-cache tzdata ca-certificates && \
    wget -q https://raw.githubusercontent.com/eficode/wait-for/v2.2.3/wait-for -O /usr/local/bin/wait-for && \
    chmod +x /usr/local/bin/wait-for
COPY --from=builder /trojan-go/build/trojan-go /usr/local/bin/$APP_NAME
COPY --from=builder /trojan-go/build/geoip.dat /usr/share/$APP_NAME/geoip.dat
COPY --from=builder /trojan-go/build/geoip-only-cn-private.dat /usr/share/$APP_NAME/geoip-only-cn-private.dat
COPY --from=builder /trojan-go/build/geosite.dat /usr/share/$APP_NAME/geosite.dat
COPY ./server.json /etc/$APP_NAME/$APP_NAME.json
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
