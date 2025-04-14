# PHP - ImageMagick

ImageMagick is a powerful library to manipulate images, a PHP extension needs
to be installed using Pecl. We always need to switch to every PHP
version and install the package for that specific version.

## Install ImageMagick extension

First install the brew ImageMagic package:

```shell
brew install imagemagick
```

Then install the php extension for every installed PHP version.
The installation will ask you what the ImageMagick location is, hit enter to let
the installer autodetect that location.

```
Please provide the prefix of Imagemagick installation [autodetect] : <enter>
```

Install ImageMagick for each installed PHP version:

```shell
sphp 8.3 && pecl install imagick
sphp 8.4 && pecl install imagick
```

This will automatically add the extension to php.ini.

> [!WARNING]
> It is possible that the extension for PHP 8.4 can not be loaded by default
> from the installed directory. You can fix this by altering the extension path
> in php.ini

```shell
vi $(brew --prefix)/etc/php/8.4/php.ini
```

The installation location of the zend extension is displayed on the screen after
the pecl package is compiled. Copy it and use it on top of php.ini:

```ini
extension="/usr/local/Cellar/php/8.4.4/pecl/20240924/imagick.so"
```

## Update ImageMagick extension

> These steps are only required when ImageMagick is updated with an existing PHP
> installation.

When ImageMagick is updated (through homebrew) PHP will start throwing errors
since its Imagick module is compiled against an older version.

First edit the php.ini config files and remove the line
`extension="imagick.so"`.

```shell
vi $(brew --prefix)/etc/php/8.3/php.ini
vi $(brew --prefix)/etc/php/8.4/php.ini
```

Reinstall ImageMagick for all PHP versions:

```shell
sphp 8.3 && pecl install -f imagick
sphp 8.4 && pecl install -f imagick
```

---

* [Next : Xdebug](PHP-Xdebug.md)
* [Overview](../README.md)
