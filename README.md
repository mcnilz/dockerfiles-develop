# docker based dev stack

Base tools for (php) web development

- nginx as load balancer on port 80 and 443 (self-configuring)
- mysql 5.7 (hostnames: mysql, mysql5, mysql57)
- mysql 8.0 (hostnames: mysql80, mysql8)
- maildev (hostnames: mail, maildev)
- portainer
- phpmyadmin
- xhgui + mongodb (php)
- mkcert

## install

Stop any old services on port 80, 443, 3306, 3308.

```bash
sudo apt install libnss3-tools # mkcert dependency
cd dev
./init
nano .env # change mysql root password if you want
../bin/docker-compose up -d
```

Open http://localhost/ . You will see all detected services available through the load balancer.

All hosts in `/etc/hosts` pointing to `127.0.0.1` will be added to the certificate. If you add new hosts to `/etc/hosts` call `./hosts_certs` to update the certificate.

## usage on a local app stack

`docker-compose.yml`
```yaml
version: '2.1'

networks:
  proxy:
    external:
      name: proxy
  mysql:
    external:
      name: mysql

services:
  app:
    image: webvariants/php:7.3
    volumes:
      - "./:/app"
      - "/etc/passwd:/etc/passwd:ro"
      - "/etc/group:/etc/group:ro"
    working_dir: "/app"
    networks:
      - proxy
      - mysql
    labels:
      - traefik.port=80
      - traefik.frontend.rule=Host:demo.docker.localhost
      - traefik.frontend.passHostHeader=true
      - traefik.docker.network=proxy
    user: "${USER_UID:?please run echo USER_UID=$(id -u) >> .env}:${USER_GID:?please run echo USER_GID=$(id -g) >> .env}"
    environment:
      PHP_IMAGE_VERSION: 2
      WEB_ROOT: "/app"
```

```bash
echo '127.0.0.1 demo.docker.localhost' | sudo tee -a /etc/hosts
echo '<?php phpinfo();' > index.php
docker-compose up -d
```

open http://demo.docker.localhost/

more example stacks [here](compose-templates)