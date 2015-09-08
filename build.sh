#!/bin/bash

set -e

export CON_NAME=wordpress_t
export REG_URL=d.nicescale.com:5000
export IMAGE=wordpress
export TAGS="4 4.3"
export BASE_IMAGE=microimages/php-fpm

docker pull $REG_URL/$BASE_IMAGE

docker tag -f $REG_URL/$BASE_IMAGE $BASE_IMAGE

docker build -t $REG_URL/microimages/$IMAGE .

#./test.sh

for t in $TAGS; do
  docker tag -f $REG_URL/microimages/$IMAGE $REG_URL/microimages/$IMAGE:$t
done

docker push $REG_URL/microimages/$IMAGE
