# Chromium novnc
```shell
docker build -t chromium-novnc .

docker run --name chromium-novnc -p 6081:6081 -p 5901:5901 -e VNC_PASS=your-password -d chromium-novnc:latest
```
