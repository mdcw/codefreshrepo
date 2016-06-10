FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

# APT update
RUN apt-get update && \

# TOOLS
apt-get -y install --fix-missing aptitude vim nano atool screen htop sudo ntp curl wget xz-utils openssh-server apt-transport-https dos2unix conspy hdparm rsync sed && \

# DOTDEB repo
bash -c 'echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list' && \
wget --tries=100 http://www.dotdeb.org/dotdeb.gpg && \
apt-key add dotdeb.gpg && \

# NGINX repo
wget http://nginx.org/keys/nginx_signing.key && \
apt-key add nginx_signing.key && \
mkdir -p /etc/apt/sources.list.d/ && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" | tee /etc/apt/sources.list.d/nginx.list && \

# MYSQL repo
bash -c 'echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.7" >> /etc/apt/sources.list' && \
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 8C718D3B5072E1F5 && \
apt-key update && \

# APT update
apt-get update && \

# DON'T UPGRADE
# apt-get upgrade -y # GRUB BUG

# MYSQL
bash -c 'debconf-set-selections <<< "mysql-server mysql-server/root_password password root"' && \
bash -c 'debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"' && \
apt-get --fix-missing install -y mysql-server-5.7 && \

# REDIS
#apt-get install -y redis-server=2:3.0.* && \
# NGINX
apt-get install -y nginx && \
# PHP7
apt-get install -y php7.0 php7.0-dbg php7.0-fpm php7.0-mysql php7.0-curl php7.0-dev php7.0-cli && \


# XDEBUG
#cd /tmp/ && \
#COMMIT="f684ac09428f902f61c7cd0f0ac770495a8ee1a8" && \
## latest to add php7 support 
#wget --tries=100 https://github.com/xdebug/xdebug/archive/${COMMIT}.zip && \
#aunpack ${COMMIT}.zip  && \
#wget --tries=100 http://xdebug.org/files/xdebug-2.4.0rc3.tgz && \
#tar -xvzf xdebug-2.4.0rc3.tgz && \
#cd xdebug-2.4.0RC3/ && \
#cp -r /tmp/xdebug-${COMMIT}/* . && \
#/usr/bin/phpize && \
#./configure --enable-xdebug && \
#make && \
#make install && \


# NODEJS
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - && \
sudo apt-get install --fix-missing -y nodejs && \

#NPM + JEKYLL + PYTHON
npm i -g gulp && \
    apt-get install -y ruby-full && \
    apt-get install -y rubygems build-essential && \
    apt-get install -y python2.7 && \
    gem install jekyll && \

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
php -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');" && \
mv composer.phar /usr/local/bin/composer

