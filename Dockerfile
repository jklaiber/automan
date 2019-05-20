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
    apache2 \
    ansible \
    python \
    py-setuptools \
    docker \
  && wget https://bootstrap.pypa.io/get-pip.py \
  && python get-pip.py \
  && pip install \
#    docker-compose \
    dnspython
RUN git clone https://github.com/jklaiber/digall_python
RUN cd digall_python \
RUN chmod +x digall.py \
RUN mv digall.py /bin/digall.py \
RUN ln -s digall.py digall


EXPOSE 7681

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "bash"]
