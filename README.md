![wordpress](http://)

## 如何使用这个镜像

```console
$ docker run -d -e MYSQL_ROOT_PASSWORD=my-secret-pw index.csphere.cn/microimages/mysql
$ docker run --name some-wordpress --link some-mysql:mysql -d index.csphere.cn/microimages/wordpress
```

下面的环境变量，推荐在启动wordpress容器时设置:

-	`-e WORDPRESS_DB_HOST=...` (默认指向被link的mysql容器的ip和端口)
-	`-e WORDPRESS_DB_USER=...` (默认"root")
-	`-e WORDPRESS_DB_PASSWORD=...` (默认取超级用户的密码 `MYSQL_ROOT_PASSWORD`)
-	`-e WORDPRESS_DB_NAME=...` (默认"wordpress")
-	`-e WORDPRESS_TABLE_PREFIX=...` (表的前缀，默认为空)
-	`-e WORDPRESS_AUTH_KEY=...`, `-e WORDPRESS_SECURE_AUTH_KEY=...`, `-e WORDPRESS_LOGGED_IN_KEY=...`, `-e WORDPRESS_NONCE_KEY=...`, `-e WORDPRESS_AUTH_SALT=...`, `-e WORDPRESS_SECURE_AUTH_SALT=...`, `-e WORDPRESS_LOGGED_IN_SALT=...`, `-e WORDPRESS_NONCE_SALT=...` (默认随机)

如果 `WORDPRESS_DB_NAME` 在数据库里不存在，将会在wordpress容器启动时自动创建，并授权 `WORDPRESS_DB_USER` 访问该数据库。

如果想通过host-ip来访问wordpess，可以设置端口映射：

```console
$ docker run --name some-wordpress --link some-mysql:mysql -p 8080:80 -d index.csphere.cn/microimages/wordpress
```

然后就可以在浏览器里打开： `http://host-ip:8080`

如果想使用已经存在的数据库，那么可以如下启动：

```console
$ docker run --name some-wordpress -e WORDPRESS_DB_HOST=10.1.2.3:3306 \
    -e WORDPRESS_DB_USER=... -e WORDPRESS_DB_PASSWORD=... -d index.csphere.cn/microimages/wordpress
```

## 通过docker-compose启动

`wordpress` 的 `docker-compose.yml`:

```yaml
wordpress:
  image: index.csphere.cn/microimages/wordpress
  links:
    - db:mysql
  ports:
    - 8080:80

db:
  image: index.csphere.cn/microimages/mysql
  environment:
    MYSQL_ROOT_PASSWORD: hellocsphere
```

运行 `docker-compose up`, 过会儿就可以访问 `http://host-ip:8080`.

## 授权和法律

该镜像由希云制造，未经允许，任何第三方企业和个人，不得重新分发。违者必究。

## 支持和反馈

该镜像由希云为企业客户提供技术支持和保障，任何问题都可以直接反馈到: `docker@csphere.cn`
