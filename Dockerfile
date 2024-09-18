FROM alpine:latest

ENV VNC_PASS=password \
    DISPLAY=:1 \
    VNC_GEOMETRY=1280x720

RUN apk update && \
    apk add --no-cache openbox tigervnc chromium websockify bash wget && \
    mkdir -p /opt/novnc && \
    wget https://github.com/novnc/noVNC/archive/refs/tags/v1.5.0.tar.gz && \
    tar -xzf v1.5.0.tar.gz --strip 1 -C /opt/novnc && \
    rm v1.5.0.tar.gz && \
    mkdir -p ~/.vnc && \
    echo "geometry=$VNC_GEOMETRY" > ~/.vnc/config && \
    rm -rf /var/cache/apk/*

CMD echo $VNC_PASS | vncpasswd -f > ~/.vnc/passwd && \
    chmod 600 ~/.vnc/passwd && \
    vncserver $DISPLAY & \
    /opt/novnc/utils/novnc_proxy --vnc localhost:5901 --listen :6081 & \
    chromium --no-sandbox --test-type --disable-dev-shm-usage --disable-gpu & \
    tail -f /dev/null
