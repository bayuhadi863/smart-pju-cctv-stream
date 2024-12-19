# Konfigurasi sumber video RTSP
VIDSOURCE="rtsp://admin:tri@2024@103.195.65.141:554/Streaming/Channels/101"

# Opsi Audio
AUDIO_OPTS="-c:a aac -b:a 128k -ac 2"

# Opsi Video (resolusi lebih rendah & bitrate optimal)
VIDEO_OPTS="-s 1280x720 -c:v libx264 -b:v 1500k -preset veryfast -tune zerolatency"

# Opsi Output HLS
OUTPUT_HLS="-hls_time 4 -hls_list_size 5 -hls_flags delete_segments"

# Path Output
OUTPUT_PATH="/var/www/html/live/simpanglima.m3u8"

# Menjalankan ffmpeg
ffmpeg -rtsp_transport tcp -v verbose -i "$VIDSOURCE" $AUDIO_OPTS $VIDEO_OPTS $OUTPUT_HLS -y "$OUTPUT_PATH"
