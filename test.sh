#!/bin/bash

set -e

CON_NAME=wordpress_t
IMAGE=index.csphere.cn/microimages/wordpress
docker rm -f "$CON_NAME" some-mysql > /dev/null 2>&1 || true

docker pull microimages/mysql
docker run -d -e MYSQL_ROOT_PASSWORD=password --name some-mysql microimages/mysql
sleep 1
docker run -d --name $CON_NAME --link some-mysql:mysql $IMAGE
sleep 10

docker exec $CON_NAME curl -H"Content-Type:application/x-www-form-urlencoded" -d 'weblog_title=hello&user_name=admin&admin_password=%23r%25eBQVc%21%296XMZMDEM&pass1-text=%23r%25eBQVc%21%296XMZMDEM&admin_password2=%23r%25eBQVc%21%296XMZMDEM&admin_email=admin%40nicescale.com&blog_public=1&Submit=Install+WordPress&language=' http://127.0.0.1/wp-admin/install.php?step=2 |grep "WordPress has been installed"

docker rm -f some-mysql
docker rm -f $CON_NAME

echo "---> The test pass"
