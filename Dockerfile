FROM alpine:3.11

RUN echo "http://dl-4.alpinelinux.org/alpine/v3.11/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/v3.11/community" >> /etc/apk/repositories && \
    apk update && \
    apk --no-cache add build-base \
		       bash \
		       sudo \
		       openssl \
		       git \
		       python3 \
		       python3-dev \
		       curl \
		       unzip \
		       libexif \
		       udev \
		       chromium \
		       chromium-chromedriver \
		       xvfb \
		       # Pillow dependecies
		       jpeg-dev \
		       zlib-dev \
		       zbar-dev \
		       freetype-dev \
		       lcms2-dev \
		       openjpeg-dev \
		       tiff-dev \
		       tk-dev \
		       tcl-dev \
		       harfbuzz-dev \
		       fribidi-dev && \
    pip3 install selenium && \
    pip3 install pyvirtualdisplay

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROMEDRIVER_BIN=/usr/bin/chromedriver \
    CHROME_PATH=/usr/lib/chromium/ \
    DISPLAY=:99
