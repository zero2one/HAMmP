# PHP

## Config file

The PHP config file depends on the version (where [php_version] 7.4, 8.4, 8.5):

```bash
vi $(brew --prefix)/etc/php/8.4/php.ini
vi $(brew --prefix)/etc/php/8.5/php.ini
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
cat /Volumes/webdev/www/_apache/log/php84-error.log
cat /Volumes/webdev/www/_apache/log/php85-error.log
```

---

* [Overview](../README.md)
