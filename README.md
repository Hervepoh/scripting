"# scripting" 

docker build -t debian-systemd:v1.0 .
docker tag debian-systemd:v1.0 hervepoh/debian-systemd:v1.0
docker push hervepoh/debian-systemd:v1.0