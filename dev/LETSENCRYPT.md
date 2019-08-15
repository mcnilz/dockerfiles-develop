# How to get a certificate

- Point domain(s) to the server
- call
  ```bash
  docker-compose exec cron-acme acme.sh --issue -d domain1.example.com -d domain2.example.com -d ... -w /usr/share/nginx/html
  ```
- use the label `dconf.cert.acme.sh` with the first domain name. in docker-compose:
  ```yaml
    labels:
      - dconf.cert.acme.sh=domain1.example.com
  ```
