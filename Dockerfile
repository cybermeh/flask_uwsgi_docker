FROM alpine:3.9

RUN apk add --no-cache tzdata
ENV TZ Europe/Belgrade

COPY requirements.txt /app/requirements.txt

RUN --update apk add --no-cache python3 \
    python3-dev \
    build-base \
    linux-headers \
	pcre-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
   	pip install -r /app/requirements.txt && \
   	apk del python3-dev build-base linux-headers pcre-dev && \
   	rm -rf /var/cache/apk/* && \
   	rm -r /root/.cache

