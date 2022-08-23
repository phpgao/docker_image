FROM alpine:3

LABEL maintainer="phpgao"

COPY docker-entrypoint.sh /opt/docker-entrypoint.sh

RUN apk add --no-cache openssh tzdata shadow curl git curl zsh && \ 
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    echo "auth    sufficient    pam_shells.so" > /etc/pam.d/chsh && \
    chsh -s $(which zsh) root && \
    chmod +x /opt/docker-entrypoint.sh

EXPOSE 22

ENTRYPOINT ["ash", "/opt/docker-entrypoint.sh"]
