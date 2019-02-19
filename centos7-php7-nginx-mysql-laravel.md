1.下载centos7minimal最新版

2.使用vm安装centos

3.网络调整为桥接模式

5. 添加DNS服务器
vi /etc/resolv.conf
nameserver 114.114.114.114
nameserver 114.114.114.115

vi /etc/sysconfig/network-scprits/ifcfg-ens33
ONBOOT=NO 改成 ONBOOT=yes

4.检查ssh服务开启

5.外部系统连接ssh

4.yum update


6.yum安装php7.2
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php72w php72w-cli php72w-common php72w-devel php72w-embedded php72w-fpm php72w-gd php72w-mbstring php72w-mysqlnd php72w-opcache php72w-pdo php72w-xml

systemctl start php-fpm

7.yum安装nginx,mysql
yum install -y nginx mysql
iptables -F
systemctl start nginx

8.启动php-fmp
php-fmp

9.修改nginx配置
```
server {
    listen 80;
    server_name example.com;
    index index.php
    client_max_body_size 50M;
    error_log /home/deploy/apps/logs/example.error.log;
    access_log /home/deploy/apps/logs/example.access.log;
    root /home/deploy/apps/example.com/current/public;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php {
        try_files $uri = 404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param SCRIPT_NAME $fastcgi_script_name;
        fastcgi_index index.php;
        fastcgi_pass 127.0.0.1:9000;
    }
}
```

10.检验web上访问php情况

11.安装composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


12.安装laravel
换源
composer config -g repo.packagist composer https://packagist.phpcomposer.com

composer create-project --prefer-dist laravel/laravel project

13.启动laravel
chown -R :apache storage/
chown -R :apache bootstrap/cache/
