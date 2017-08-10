# Homebrew

## Install Homebrew
Install homebrew as described in their documentation:

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Make sure to add the Homebrew's sbin directory to the path:

```bash
$ echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
```


## OpenSSL
OpenSSL is needed for PHP 5.6 
(source: http://akrabat.com/ssl-certificate-verification-on-php-5-6/).

```bash
$ brew install openssl
```



## Wget
Tools like drush require wget. Install it using homebrew:
 
```bash
$ brew install wget
```


## Imagemagic
We use imagemagic in PHP to modify images.

There is a problem with the libjpeg version included in Homebrew and the one
supported by php. To overcome that problem we install libjpeg version 8d from 
source:

```bash
$ wget -c http://www.ijg.org/files/jpegsrc.v8d.tar.gz
$ tar -xzf jpegsrc.v8d.tar.gz
$ cd jpeg-8d
$ ./configure
$ make
$ cp ./.libs/libjpeg.8.dylib /usr/local/opt/jpeg/lib
$ cd ../
$ rm -R jpeg-8d
$ rm jpegsrc.v8d.tar.gz
```

Install imagemagick:

```bash
$ brew install imagemagick@6
$ brew link imagemagick@6 --force
```




---
* [Next : MariaDB](./MariaDB.md)
* [Overview](../README.md)
