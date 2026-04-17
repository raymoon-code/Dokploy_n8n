# Stage 1: Lấy ffmpeg + libs từ Alpine
FROM alpine:3.19 AS ffmpeg-source
RUN apk add --no-cache ffmpeg

# Stage 2: n8n
FROM docker.n8n.io/n8nio/n8n:2.7.4

USER root

# Copy ffmpeg binaries
COPY --from=ffmpeg-source /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-source /usr/bin/ffprobe /usr/bin/ffprobe

# Copy thư viện ffmpeg
COPY --from=ffmpeg-source /usr/lib/ /usr/lib/
COPY --from=ffmpeg-source /lib/ /lib/

# Chỉ thêm các package canvas cần thiết
RUN apk add --no-cache \
  cairo-dev \
  pango-dev \
  jpeg-dev \
  giflib-dev \
  pixman-dev \
  build-base \
  python3 \
  pkgconf

RUN npm install -g canvas

USER node
