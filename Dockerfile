FROM alpine:3.11

RUN echo "http://dl-4.alpinelinux.org/alpine/v3.11/main" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/v3.11/community" >> /etc/apk/repositories && \
	
RUN apk update && \
    apk --no-cache add build-base \
		       python3 \
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

ADD depends /depends
RUN cd /depends && ./install_webp.sh && ./install_imagequant.sh && ./install_raqm.sh

RUN /usr/sbin/adduser -D pillow && \
    pip3 install virtualenv && virtualenv /vpy3 && \
    /vpy3/bin/pip install --upgrade pip && \
    /vpy3/bin/pip install olefile pytest pytest-cov && \
    /vpy3/bin/pip install numpy --only-binary=:all: || true && \
    chown -R pillow:pillow /vpy3

USER pillow
CMD ["depends/test.sh"]

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROMEDRIVER_BIN=/usr/bin/chromedriver \
    CHROME_PATH=/usr/lib/chromium/ \
    DISPLAY=:99
