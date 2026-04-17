FROM docker.n8n.io/n8nio/n8n:latest

# Chuyển sang user root để cài phần mềm
USER root

# Cài ffmpeg vào trong container (Alpine Linux dùng apk)
RUN apk add --no-cache ffmpeg && \
    rm -rf /var/cache/apk/*

# Chuyển lại user node (bảo mật)
USER node
