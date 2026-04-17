# Stage 1: Lấy ffmpeg + toàn bộ libs từ Alpine
FROM alpine:3.19 AS ffmpeg-source
RUN apk add --no-cache ffmpeg

# Stage 2: n8n
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Copy ffmpeg binaries
COPY --from=ffmpeg-source /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-source /usr/bin/ffprobe /usr/bin/ffprobe

# Copy TẤT CẢ thư viện ffmpeg cần (bao gồm libdrm, libxcb, v.v.)
COPY --from=ffmpeg-source /usr/lib/ /usr/lib/
COPY --from=ffmpeg-source /lib/ /lib/

# Them canvas dependencies
RUN apk add --no-cache \
  cairo-dev \
  pango-dev \
  jpeg-dev \
  giflib-dev \
  pixman-dev \
  pangomm-dev \
  libjpeg-turbo-dev \
  build-base \
  python3 \
  pkgconfig

# Cai canvas
RUN npm install canvas

USER node
