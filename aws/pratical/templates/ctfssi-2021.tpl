${file("userdata-base.tpl")}

sudo docker container run -d -ti \
    -e  UPLOAD_FOLDER=/var/uploads \
    -e  DATABASE_URL=mysql+pymysql://ctfd:ctfd@db/ctfd \
    -e  REDIS_URL=redis://cache:6379 \
    -e  WORKERS=1 \
    -e  LOG_FOLDER=/var/log/CTFd \
    -e  ACCESS_LOG=- \
    -e  ERROR_LOG=- \
    -e  REVERSE_PROXY=true \
    -p 8000:80 doombringerazurai/ctfssi-ctfd:2021