# PHP

## Config file

The PHP config file depends on the version (where [php_version] 7.2, 7.3, 7.4):

```bash
vi /usr/local/etc/php/7.2/php.ini
vi /usr/local/etc/php/7.3/php.ini
vi /usr/local/etc/php/7.4/php.ini
```

## Global log file

PHP is running using PHP-FPM. The log file of the currently activated PHP
version is located at:

```bash
cat "$(brew --prefix)/var/log/php-fpm.log"
```

## Error log file per PHP version

The PHP error file depends on the version:

```bash
cat /Volumes/webdev/www/_apache/log/php72-error.log
cat /Volumes/webdev/www/_apache/log/php73-error.log
cat /Volumes/webdev/www/_apache/log/php74-error.log
```

---

* [Overview](../README.md)
