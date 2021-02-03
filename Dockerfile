FROM alpine:3.13.1

LABEL maintainer="Terence Westphal <terence.westphal@42.nl>"

ENV PATH="/opt/bin:$PATH" \
    SOURCE_URL="https://github.com/jay0lee/GAM.git"

ADD .bashrc /root/.bashrc
RUN apk add gcc g++ make libffi-dev openssl-dev
RUN apk add --update --no-cache bash curl git python3 py-openssl py-pip \
    && rm -rf /var/cache/apk/* 

RUN mkdir -p /opt/bin \
    && git clone ${SOURCE_URL} /opt/gam \
    && pip install -r /opt/gam/src/requirements.txt    \
    && ln -s /opt/gam/src/gam.py /opt/bin/gam \
    && touch /opt/gam/src/{nobrowser.txt,noupdatecheck.txt}

WORKDIR /root
ENTRYPOINT ["/bin/bash"]