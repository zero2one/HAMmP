# PHP

## Install multiple PHP version

We want an environment where we can switch between the current active PHP 
versions. This are 5.6.x, 7.0.x, 7.1.x and 7.2.x.

This describes how to setup Apache with multiple PHP versions.

To do so we install PHP 5.6 > 7.2. Feel free to leave out the versions you 
don't need.

```bash
brew install php@5.6
brew install php@7.0
brew install php@7.1
brew install php@7.2
```

## Configure PHP

Set timezone and change other PHP settings (sudo is needed here to get the 
current timezone on OS X) to be more developer-friendly, and add a PHP error 
log (without this, you may get Internal Server Errors if PHP has errors to 
write and no logs to write to):

We update:

* `date.timezone` : to the timezone defined in your laptop.
* `memory_limit` : 512MB
* `post_max_size` : 200M (needed for large uploads)
* `upload_max_filesize` : 100M (needed for large uploads)
* `default_socket_timeout` : 600
* `max_execution_time` : 30
* `max_input_time` : 600
* `error_log` : /Volumes/webdev/www/_apache/log/php-error_log

We need to update the config for each PHP version:

#### PHP 5.6

```bash
sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 30|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = /Volumes/webdev/www/_apache/log/php56-error.log'$'\n' $(brew --prefix)/etc/php/5.6/php.ini
```

#### PHP 7.0

```bash
sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 30|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = /Volumes/webdev/www/_apache/log/php70-error.log'$'\n' $(brew --prefix)/etc/php/7.0/php.ini
```

#### PHP 7.1

```bash
sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 30|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = /Volumes/webdev/www/_apache/log/php71-error.log'$'\n' $(brew --prefix)/etc/php/7.1/php.ini
```

#### PHP 7.2

```bash
sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 30|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = /Volumes/webdev/www/_apache/log/php71-error.log'$'\n' $(brew --prefix)/etc/php/7.2/php.ini
```

## Switch back to PHP 5.6
Switch pack to PHP 5.6 (or the lowest version you have installed).

```bash
brew unlink php@7.2 && brew link --force --overwrite php@5.6
```

Close all terminal windows and open a new one. This will open a new session with
all the new paths and will use the newly installed PHP versions.

Check if you have the correct version:

```bash
php -v
```

This should show you the version you just switched back to.

```
PHP 5.6.35 (cli) (built: Apr 12 2018 03:02:25)
Copyright (c) 1997-2016 The PHP Group
Zend Engine v2.6.0, Copyright (c) 1998-2016 Zend Technologies
    with Zend OPcache v7.0.6-dev, Copyright (c) 1999-2016, by Zend Technologies
```

## Restart Apache

Finaly we can restart Apache:

```bash
brew services restart httpd
```

## Start PHP-FPM

The Apache configuration files that are included in this repository (and you
clone locally during the Apache installation) contains already the configuration
to serve PHP scripts using PHP-FPM. We only need to start the PHP-FPM service: 

```bash
brew services start php@5.6
```

The config is located at `/Volumes/webdev/www/_apache/conf.d/php-fpm.conf`.

## Test

You should now be able to run PHP scripts:

* http: `http://localhost/phpinfo.php`
* https: `https://localhost/phpinfo.php`

## Switch between PHP versions

The `/Volumes/webdev/www/_apache/bin` directory of the HAMmP repository contains
a helper script to switch between the different PHP versions.

Run the command with the PHP version you want to enable:

```
sphp 5.6
sphp 7.0
sphp 7.1
sphp 7.2
```

## Install PHP extensions

PHP extensions are installed using Pecl. We always need to switch to every PHP
version and install the package for that specific version.



### Install ImageMagick extension

ImageMagick is a powerfull library to manipulate images.

First install the brew Imagemagic package:

```bash
brew install imagemagick
```

Then install the php extension for every installed PHP version.
The installation will ask you what the Imagemagick location is, hit enter to let
the installer autodetect that location.

```
Please provide the prefix of Imagemagick installation [autodetect] : <enter>
```

#### PHP 5.6

```bash
sphp 5.6 && pecl install imagick
```

#### PHP 7.0

```bash
sphp 7.0 && pecl install imagick
```

#### PHP 7.1

```bash
sphp 7.1 && pecl install imagick
```

#### PHP 7.2

```bash
sphp 7.2 && pecl install imagick
```


























### Install OpCache

The optional Opcache extension will speed up your PHP environment 
dramatically, so let's install it. Then, we'll bump up the opcache memory limit:

#### PHP 5.6

```bash
brew link php56
brew install -v php56-opcache
/usr/bin/sed -i '' "s|^\(\;\)\{0,1\}[[:space:]]*\(opcache\.enable[[:space:]]*=[[:space:]]*\)0|\21|; s|^;\(opcache\.memory_consumption[[:space:]]*=[[:space:]]*\)[0-9]*|\1256|;" $(brew --prefix)/etc/php/5.6/php.ini
```

#### PHP 7.0

```bash
brew unlink php56 && brew link php70
brew install -v php70-opcache
/usr/bin/sed -i '' "s|^\(\;\)\{0,1\}[[:space:]]*\(opcache\.enable[[:space:]]*=[[:space:]]*\)0|\21|; s|^;\(opcache\.memory_consumption[[:space:]]*=[[:space:]]*\)[0-9]*|\1256|;" $(brew --prefix)/etc/php/7.0/php.ini
```

#### PHP 7.1

```bash
brew unlink php70 && brew link php71
brew install -v php71-opcache
/usr/bin/sed -i '' "s|^\(\;\)\{0,1\}[[:space:]]*\(opcache\.enable[[:space:]]*=[[:space:]]*\)0|\21|; s|^;\(opcache\.memory_consumption[[:space:]]*=[[:space:]]*\)[0-9]*|\1256|;" $(brew --prefix)/etc/php/7.1/php.ini
```

#### PHP 7.2

```bash
brew unlink php71 && brew link php72
brew install -v php71-opcache
/usr/bin/sed -i '' "s|^\(\;\)\{0,1\}[[:space:]]*\(opcache\.enable[[:space:]]*=[[:space:]]*\)0|\21|; s|^;\(opcache\.memory_consumption[[:space:]]*=[[:space:]]*\)[0-9]*|\1256|;" $(brew --prefix)/etc/php/7.2/php.ini
```

## Certificate files

If you want to access URI (eg. services) trough PHP that are hosted on self 
signed ssl domains, you can trust those certificates by adding them to the MacOS
keychain.

You need to add the keychain ca files to the PHP configuration:

Edit the ini file of the proper PHP version:

```bash
vi $(brew --prefix)/etc/php/5.6/php.ini
vi $(brew --prefix)/etc/php/7.0/php.ini
vi $(brew --prefix)/etc/php/7.1/php.ini
vi $(brew --prefix)/etc/php/7.2/php.ini
```

Uncomment and fill in the keychain paths:

```
[openssl]
; The location of a Certificate Authority (CA) file on the local filesystem
; to use when verifying the identity of SSL/TLS peers. Most users should
; not specify a value for this directive as PHP will attempt to use the
; OS-managed cert stores in its absence. If specified, this value may still
; be overridden on a per-stream basis via the "cafile" SSL stream context
; option.
openssl.cafile=/usr/local/etc/openssl/cert.pem
 
; If openssl.cafile is not specified or if the CA file is not found, the
; directory pointed to by openssl.capath is searched for a suitable
; certificate. This value must be a correctly hashed certificate directory.
; Most users should not specify a value for this directive as PHP will
; attempt to use the OS-managed cert stores in its absence. If specified,
; this value may still be overridden on a per-stream basis via the "capath"
; SSL stream context option.
openssl.capath=/usr/local/etc/openssl/certs
```

## Sources

This PHP install guide is based on the
[Grav guide](https://getgrav.org/blog/macos-sierra-apache-multiple-php-versions)
to install multiple PHP versions on one OSX installation. The main difference is
that this guide uses PHP-FPM for easy PHP version switching where the Grav guide
used Apache mod-php.

---

* [Next : Xdebug](PHP-Xdebug.md)
* [Overview](../README.md)
