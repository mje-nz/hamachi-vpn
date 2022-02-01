FROM ubuntu:18.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yqq --no-install-recommends \
        curl \
        psmisc \
        python-pip \
        python-setuptools \
        python-wheel \
        supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir supervisor-stdout && \
    curl https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb -o /tmp/hamachi.deb && \
    dpkg -i /tmp/hamachi.deb && \
    /etc/init.d/logmein-hamachi stop && \
    rm -f /etc/init.d/logmein-hamachi && \
    rm -rf /tmp/*

COPY supervisord.conf /etc/supervisor/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
