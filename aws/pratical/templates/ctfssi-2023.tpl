${file("userdata-base.tpl")}

sudo docker network create internal
sudo docker container run -d -ti \
    --name cache \
    --network internal redis:4
sudo docker container run -d -ti \
    --name ctfd \
    --network internal \
    -e UPLOAD_FOLDER=/var/uploads \
    -e DATABASE_URL=mysql+pymysql://${db_username}:${db_password}@${db_url}/${db_name} \
    -e REDIS_URL=redis://cache:6379 \
    -e WORKERS=1 \
    -e LOG_FOLDER=/var/log/CTFd \
    -e ACCESS_LOG=- \
    -e ERROR_LOG=- \
    -e REVERSE_PROXY=true \
    -p 80:8000 ctfd/ctfd:latest