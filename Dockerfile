# Stage 1: Lấy ffmpeg từ Alpine
FROM alpine:3.19 AS ffmpeg-source
RUN apk add --no-cache ffmpeg

# Stage 2: Build n8n với ffmpeg bên trong
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Copy ffmpeg binary từ Alpine stage
COPY --from=ffmpeg-source /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-source /usr/bin/ffprobe /usr/bin/ffprobe

# Copy các thư viện ffmpeg cần thiết
COPY --from=ffmpeg-source /usr/lib/libav* /usr/lib/
COPY --from=ffmpeg-source /usr/lib/libsw* /usr/lib/
COPY --from=ffmpeg-source /usr/lib/libpostproc* /usr/lib/

USER node
