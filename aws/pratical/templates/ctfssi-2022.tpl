${file("userdata-base.tpl")}

curl https://raw.githubusercontent.com/EACH-inTheShell/CTFSSI_2022/main/docker-compose.yml -o /tmp/docker-compose.yaml
sudo /usr/local/bin/docker-compose -f /tmp/docker-compose.yaml up -d