# Menggunakan Ubuntu sebagai image dasar
FROM ubuntu:20.04

# Non-interaktif untuk instalasi
ENV DEBIAN_FRONTEND=noninteractive

# Update dan install dependensi
RUN apt-get update && apt-get install -y \
    ffmpeg \
    nginx \
    bash \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Menyalin file konfigurasi dan script ke dalam container
COPY cctv-rtsp.sh /usr/local/bin/cctv-rtsp.sh
COPY index.html /var/www/html/index.html

# Berikan izin eksekusi ke script
RUN chmod +x /usr/local/bin/cctv-rtsp.sh

# Membuat folder output untuk HLS
RUN mkdir -p /var/www/html/live && chmod 777 /var/www/html/live

# Salin konfigurasi Nginx (opsional)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 untuk Nginx
EXPOSE 80

# Menjalankan Nginx dan FFmpeg
CMD ["/bin/bash", "-c", "/usr/local/bin/cctv-rtsp.sh & nginx -g 'daemon off;'"]
