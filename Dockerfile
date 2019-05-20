FROM alpine:3.9
LABEL maintainer "Julian Klaiber - https://github.com/jklaiber/automan"

RUN apk add --no-cache \
    bash \
    tini \
    ttyd

RUN apk update && apk add \
    gcc \
    tcpdump \
    git \
    htop \
    nmap \
    net-tools \
    curl \
    wget \
    iperf3 \
    tshark \
    iproute2 \
    tcptraceroute \
    openssl \
    strace \
    ngrep \
    dhcping \
    bind-tools \
    apache2 \
    elinks \
    ansible \
    python3 \
    py3-setuptools \
    docker \
  && wget https://bootstrap.pypa.io/get-pip.py \
  && python3 get-pip.py \
  && pip3 install \
#    docker-compose \
    dnspython
RUN git clone https://github.com/jklaiber/digall_python
RUN cd digall_python \
RUN chmod +x digall.py \
RUN mv digall.py /bin/digall.py \
RUN ln -s digall.py digall

RUN wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 -O /usr/local/bin/ctop && chmod +x /usr/local/bin/ctop
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump

ADD motd /etc/motd

EXPOSE 7681

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "bash"]
