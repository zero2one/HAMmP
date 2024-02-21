# PHP - ImageMagick

ImageMagick is a powerful library to manipulate images, a PHP extension needs
to be installed using Pecl. We always need to switch to every PHP
version and install the package for that specific version.

## Install ImageMagick extension

First install the brew ImageMagic package:

```bash
brew install imagemagick
```

Then install the php extension for every installed PHP version.
The installation will ask you what the ImageMagick location is, hit enter to let
the installer autodetect that location.

```
Please provide the prefix of Imagemagick installation [autodetect] : <enter>
```

Install ImageMagick for each installed PHP version:

```bash
sphp 8.2 && pecl install imagick
sphp 8.3 && pecl install imagick
```

## Update ImageMagick extension

> These steps are only required when ImageMagick is updated with an existing PHP
> installation.

When ImageMagick is updated (through homebrew) PHP will start throwing errors
since its Imagick module is compiled against an older version.

First edit the php.ini config files and remove the line
`extension="imagick.so"`.

```
vi $(brew --prefix)/etc/php/8.1/php.ini
vi $(brew --prefix)/etc/php/8.2/php.ini
```

Reinstall ImageMagick for all PHP versions:

```
sphp 8.1 && pecl install -f imagick
sphp 8.2 && pecl install -f imagick
```

---

* [Next : Xdebug](PHP-Xdebug.md)
* [Overview](../README.md)
