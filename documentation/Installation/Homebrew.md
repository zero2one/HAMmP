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




---
* [Next : MariaDB](./MariaDB.md)
* [Overview](../README.md)
