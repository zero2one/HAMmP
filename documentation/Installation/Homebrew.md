# Homebrew

## Install Homebrew

Install homebrew as described in their documentation:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Wget

Tools like drush require wget. Install it using homebrew:
 
```bash
brew install wget
```

> Note: This will also install openssl. This is needed for PHP 5.6. 

## pkg-config

pkg-config is required to install some PHP extensions. Install it up-front:

```bash
brew install pkg-config
```

## Update GIT to latest version

Homebrew has a more recent version of Git.

```bash
brew install git
```

---

* [Next : MariaDB](./MariaDB.md)
* [Overview](../README.md)
