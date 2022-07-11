# PHP

## Install multiple PHP version

We want an environment where we can switch between the current active PHP 
versions. These are 7.3.x, 7.4.x and 8.0.x.

This describes how to setup Apache with multiple PHP versions.

To do so we install PHP 7.3, 7.4 and 8.0. Feel free to leave out the versions
you don't need.

```bash
brew install php@7.3
brew install php@7.4
brew install php@8.0
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

#### PHP 7.3

```bash
sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 30|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = /Volumes/webdev/www/_apache/log/php71-error.log'$'\n' $(brew --prefix)/etc/php/7.3/php.ini
```

#### PHP 7.4

```bash
sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 30|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = /Volumes/webdev/www/_apache/log/php56-error.log'$'\n' $(brew --prefix)/etc/php/7.4/php.ini
```

#### PHP 8.0

```bash
sed -i '-default' -e 's|^;\(date\.timezone[[:space:]]*=\).*|\1 \"'$(sudo systemsetup -gettimezone|awk -F"\: " '{print $2}')'\"|; s|^\(memory_limit[[:space:]]*=\).*|\1 512M|; s|^\(post_max_size[[:space:]]*=\).*|\1 200M|; s|^\(upload_max_filesize[[:space:]]*=\).*|\1 100M|; s|^\(default_socket_timeout[[:space:]]*=\).*|\1 600|; s|^\(max_execution_time[[:space:]]*=\).*|\1 30|; s|^\(max_input_time[[:space:]]*=\).*|\1 600|; $a\'$'\n''\'$'\n''; PHP Error log\'$'\n''error_log = /Volumes/webdev/www/_apache/log/php80-error.log'$'\n' $(brew --prefix)/etc/php/8.0/php.ini
```

## Switch back to PHP 7.3

Switch back to PHP 7.3 (or the lowest version you have installed).

```bash
brew unlink php@8.0 && brew link --force --overwrite php@7.3
```

Close all terminal windows and open a new one. This will open a new session with
all the new paths and will use the newly installed PHP versions.

Check if you have the correct version:

```bash
php -v
```

This should show you the version you just switched back to.

```
PHP 7.3.25 (cli) (built: Nov 30 2020 14:27:01) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.25, Copyright (c) 1998-2018 Zend Technologies
    with Xdebug v2.7.2, Copyright (c) 2002-2019, by Derick Rethans
    with Zend OPcache v7.3.25, Copyright (c) 1999-2018, by Zend Technologies
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
brew services start php@7.3
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
sphp 7.3
sphp 7.4
sphp 8.0
```

## Certificate files

If you want to access URI (eg. services) trough PHP that are hosted on self 
signed ssl domains, you can trust those certificates by adding them to the MacOS
keychain.

You need to add the keychain ca files to the PHP configuration:

Edit the ini file of the proper PHP version:

```bash
vi $(brew --prefix)/etc/php/7.3/php.ini
vi $(brew --prefix)/etc/php/7.4/php.ini
vi $(brew --prefix)/etc/php/8.0/php.ini
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
openssl.cafile = "/usr/local/etc/openssl@1.1/cert.pem"

; If openssl.cafile is not specified or if the CA file is not found, the
; directory pointed to by openssl.capath is searched for a suitable
; certificate. This value must be a correctly hashed certificate directory.
; Most users should not specify a value for this directive as PHP will
; attempt to use the OS-managed cert stores in its absence. If specified,
; this value may still be overridden on a per-stream basis via the "capath"
; SSL stream context option.
openssl.capath = "/usr/local/etc/openssl@1.1/certs"
```

## Sources

This PHP install guide is based on the
[Grav guide](https://getgrav.org/blog/macos-sierra-apache-multiple-php-versions)
to install multiple PHP versions on one OSX installation. The main difference is
that this guide uses PHP-FPM for easy PHP version switching where the Grav guide
used Apache mod-php.

---

* [Next : ImageMagick](PHP-ImageMagick.md)
* [Overview](../README.md)
