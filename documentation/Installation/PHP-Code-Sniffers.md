# PHP Code Sniffers

> Note : It is recommended to install these tools on per-project base using
> Composer. Installing these tools globally can be handy when writing/debugging
> projects where no composer is used.

## Requirements

* [Composer](PHP-Composer.md)
  We are installing the tools through composer, make sure that Composer is 
  installed globally.

## PHP Code Sniffer

PHP_CodeSniffer is a PHP5+ script that tokenises PHP, JavaScript and CSS files 
to detect violations of a defined coding standard. 

It is an essential development tool that ensures your code remains clean and 
consistent. It can also help prevent some common semantic errors made by 
developers.

```bash
composer global require "squizlabs/php_codesniffer=*"
```

Usage:

```bash
phpcs [file or directory]
```

See https://github.com/squizlabs/PHP_CodeSniffer

### Use PHP_CodeSniffer in PHPStorm

Get the path for phpcs:

```bash
which phpcs
```

Set this path in 

* PHPStorm -> Preferences -> Languages & Frameworks -> PHP -> Code Sniffer.

## PHP mess detector

It is a spin-off project of PHP Depend and aims to be a PHP equivalent of the 
well known Java tool PMD. 

PHPMD can be seen as an user friendly and easy to configure frontend for the 
raw metrics measured by PHP Depend.

What PHPMD does is: It takes a given PHP source code base and look for several 
potential problems within that source. 

These problems can be things like:

* Possible bugs
* Suboptimal code
* Overcomplicated expressions
* Unused parameters, methods, properties

Installation:

```bash
composer global require "phpmd/phpmd=*"
```

Usage:

```bash
phpmd [file or directory] text codesize,design,naming,unusedcode
```
  
See http://phpmd.org/

## PHP Copy/Paste Detector (PHPCPD)

phpcpd is a Copy/Paste Detector (CPD) for PHP code.

Installation:

```bash
composer global require 'sebastian/phpcpd=*'
```

Usage:

```bash
phpcpd [file or folder]
```

See https://github.com/sebastianbergmann/phpcpd

## Upgrade Tools

These tools are under active development. This are the steps to update to the 
latest version:

```bash
composer global update drupal/coder
```

---

* [Next : Drupal Code Standards](./Drupal-Code-Standards.md)
* [Overview](../README.md)
