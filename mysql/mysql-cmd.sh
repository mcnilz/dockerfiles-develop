#!/bin/bash

docker exec -ti mysql /bin/bash -c "mysql -u root -p\${MYSQL_ROOT_PASSWORD}"
