# PHPUnit
PHPUnit is a programmer-oriented testing framework for PHP.

It is an instance of the xUnit architecture for unit testing frameworks.


## Requirements
* [Composer](PHP-Composer.md)
  We are installing PHPUnit trough composer, make sure that Composer is 
  installed globally.


## Installaton
PHPUnit is best installed on per project basis. It can be handy to have it also
installed globally.

Install PHPUnit 5.7 (6.x requires PHP 7.0 or higher):

```bash
$ composer global require phpunit/phpunit ^5.7
```


## Upgrade PHPUnit
PHPunit is under active development. This are the steps to update to the latest 
version:

```bash
$ composer global update
```




---
* [Next : PHP Code Sniffers](./PHP-Code-Sniffers.md)
* [Overview](../README.md)
