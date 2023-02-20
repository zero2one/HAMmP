# HAMmP

**HAMmP** is an acronym for:

* **H**omebrew : All components installed using Homebrew.
* **A**pache : Web server.
* **M**ySQL : Database server
* **m**ultiple **P**HP : Install multiple PHP versions and switch between them.

Mac OS X and macOS comes with Apache and PHP pre-installed, but it's not in a
great configuration, is not the latest version, requires root to make lots of 
changes, and can introduce issues with file ownership and permissions.

We prefer to use Homebrew to avoid these problems and because it's easier to 
keep up to date with newer versions of each component and extend 
customisation. 

This documentation describes how to setup a Apache-MySQL-PHP stack with 
multiple PHP versions and optional extra's.

## Index

### Installation

* [Preparation](Installation/Preparation.md)
* [Homebrew](Installation/Homebrew.md)
* [MariaDB](Installation/MariaDB.md)
* [Apache](Installation/Apache.md)
* [PHP](Installation/PHP.md)
* [ImageMagick](Installation/PHP-ImageMagick.md)
* [Xdebug](Installation/PHP-Xdebug.md)
* [Composer](Installation/PHP-Composer.md)
* [Drush](Installation/Drupal-Drush.md)
* [MailHog](Installation/Mailhog.md)
* [Management](Installation/Management.md)

### Optional extra's

* [Apache Solr](Optional/Apache-Solr.md)
* [Java](Optional/Java.md)
* [Node JS](Optional/Node-js.md)
* [Python](Optional/Python.md)
* [Redis](Optional/Redis.md)
* [Ruby](Optional/Ruby.md)
* [Tika](Optional/Tika.md)
* [Run a single vhost on a different PHP version](Optional/Vhost-on-different-php-version.md)

### How to's

* [Add Apache vhost](HowTo/Add-Apache-Vhost.md)
* [Add Solr core](HowTo/Apache-Solr-Add-Core.md)
* [MariaDB Back-up](HowTo/MariaDB-Backup.md) : Take a dump of each MariaDB 
  database in its own SQL File.

### Troubleshooting

* [Homebrew](Troubleshooting/Homebrew.md)
* [MariaDb](Troubleshooting/MariaDb.md)
* [Apache](Troubleshooting/Apache.md)
* [PHP](Troubleshooting/PHP.md)

## Resources

This install guide is based on:

* [Local Development Environment: Apache, PHP, and MySQL with Homebrew](https://echo.co/blog/os-x-1010-yosemite-local-development-environment-apache-php-and-mysql-homebrew)
* [macOS 10.13 High Sierra Apache Setup: Multiple PHP Versions](https://getgrav.org/blog/macos-sierra-apache-multiple-php-versions)
* [Apache Setup: Multiple PHP Versions](http://getgrav.org/blog/mac-os-x-apache-setup-multiple-php-versions)

* This project is [hosted on GitHub](https://github.com/zero2one/HAMmP).
