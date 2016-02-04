#!/bin/bash

set -e

export CON_NAME=wordpress_t
export REG_URL=index.csphere.cn
export IMAGE=microimages/wordpress
export TAGS="4 4.4 4.4.2"
export BASE_IMAGE=microimages/php-apache

docker pull $BASE_IMAGE

docker build -t $IMAGE .

./test.sh

docker tag -f $IMAGE $REG_URL/$IMAGE
for t in $TAGS; do
  docker tag -f $IMAGE $REG_URL/$IMAGE:$t
  docker tag -f $IMAGE $IMAGE:$t
done

docker push $IMAGE
docker push $REG_URL/$IMAGE
