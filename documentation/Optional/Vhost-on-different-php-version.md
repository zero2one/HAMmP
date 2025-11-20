# Run a single vhost on a different PHP version

Sometimes you need to run a vhost to run a different PHP version while the other
vhosts still run the default PHP version.

An example can be that a vhost is used as API backend for another project but
still runs on an older PHP version.

This describes how you can do this.

## Install desired PHP version

Install the required PHP version as
[described in the PHP installation](../Installation/PHP.md) manual. Make sure
you also install ImageMagick & XDebug.

## Alter the PHP-FPM port

PHP-FPM runs by default on port 9000, we need to change the port of the version
we wants to run parallel with the default.

Edit the php-fpm config file of the desired PHP version:

```shell
vi $(brew --prefix)/etc/php/[PHP_VERSION]/php-fpm.d/www.conf
```

Search for the `listen = 127.0.0.1:9000` rule and change it to `90+PHPVERSION`.

Example for PHP 8.4: `listen = 127.0.0.1:9084`

Make sure that the current PHP version is set to the desired version.

Now start the PHP-FPM service for the PHP version you want to run in parallel:

```shell
brew services start php@VERSION
```

There should now be multiple PHP-FPM processes running:

```shell
sudo lsof -i -n -P|grep php-fpm
```

```
php-fpm    2304       ... TCP 127.0.0.1:9000 (LISTEN)
php-fpm   11333       ... TCP 127.0.0.1:9000 (LISTEN)
php-fpm   11866       ... TCP 127.0.0.1:9000 (LISTEN)
php-fpm   21337       ... TCP 127.0.0.1:9084 (LISTEN)
php-fpm   76296       ... TCP 127.0.0.1:9084 (LISTEN)
php-fpm   76297       ... TCP 127.0.0.1:9084 (LISTEN)
```

## Configure Apache

Add the proxy to the Apache configuration:

```shell
vi /Volumes/webdev/www/_apache/conf.d/php-fpm.conf
```

Add a Proxy directive for each PHP version you want to run in parallel:

```
# PHP 8.4 proxy.
<Proxy "fcgi://localhost:9084/">
  ProxySet timeout=900
</Proxy>

# PHP 8.5 proxy.
<Proxy "fcgi://localhost:9085/">
  ProxySet timeout=900
</Proxy>

...

Restart Apache:

```shell
brew services restart httpd
```

## Vhost configuration

Now alter the vhost you want a specific PHP version for. Add following lines to
it, refer to the proper PHP-FPM port:

```
  <FilesMatch \.php$>
    SetHandler proxy:fcgi://localhost:9084
  </FilesMatch>
```

Restart Apache, you now should have the specific PHP version for this vhost.

## Aliases

It can be handy to get specific aliases for the specific PHP version.

Add following alias for a specific PHP version:

```bash
alias php84="$(brew --prefix)/opt/php@8.4/bin/php"
```

Add after this aliases also composer & drush aliases:

```
alias composer84="php84 /usr/local/bin/composer"
alias drush84="php84 /Users/cuyperpe/.composer/vendor/bin/drush"
```

## Sources

* https://kevdees.com/install-nginx-multiple-php-versions-on-macos-13-ventura/
