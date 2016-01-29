#!/bin/bash

set -e

export CON_NAME=wordpress_t
export REG_URL=d.nicescale.com:5000
export IMAGE=wordpress
export TAGS="4 4.3"
export BASE_IMAGE=microimages/php-apache

docker pull $BASE_IMAGE

docker build -t microimages/$IMAGE .

#./test.sh

for t in $TAGS; do
  docker tag -f microimages/$IMAGE microimages/$IMAGE:$t
done

docker push microimages/$IMAGE
