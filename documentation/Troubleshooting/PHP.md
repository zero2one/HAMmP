# PHP

## Config file

The PHP config file depends on the version (where [php_version] 7.4, 8.1, 8.2):

```bash
vi $(brew --prefix)/etc/php/7.4/php.ini
vi $(brew --prefix)/etc/php/8.1/php.ini
vi $(brew --prefix)/etc/php/8.2/php.ini
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
cat /Volumes/webdev/www/_apache/log/php74-error.log
cat /Volumes/webdev/www/_apache/log/php81-error.log
cat /Volumes/webdev/www/_apache/log/php82-error.log
```

---

* [Overview](../README.md)
