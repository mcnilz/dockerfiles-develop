# How to start a service in production

- Point domain(s) to the server
- to create the letsencrypt certificate call
  ```bash
  docker-compose exec cron-acme acme.sh --issue -d domain1.example.com -d domain2.example.com -d ... -w /usr/share/nginx/html
  ```
- use the label `dconf.cert.acme.sh` with the first domain name. in docker-compose:
  ```yaml
    labels:
      - dconf.cert.acme.sh=domain1.example.com
  ```

- run service with docker-compose:
  ```yaml
    version: '2.1'

    networks:
        mysql:
            external:
                name: mysql

        proxy:
            external:
                name: proxy

    services:
        app:
            image: [...]
            [...]
            labels:
            - traefik.enable=true
            - traefik.port=80
            - traefik.frontend.rule=Host:domain1.example.com,domain2.example.com
            - traefik.docker.network=proxy
            - dconf.cert.acme.sh=domain1.example.com
  ```

# How to add http authentication to a service

```yaml
    labels:
      - dconf.auth.username=[...]
      - dconf.auth.password=[...]
```
