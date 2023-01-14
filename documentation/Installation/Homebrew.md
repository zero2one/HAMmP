# Homebrew

## Install Homebrew

Install homebrew as described in their documentation:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

When command line tools are run from within applications (e.g. Sourcetree), an
command line is used without loading the .bash_profile file. This results in
commands that not can find binaries installed trough homebrew.

Run the following command and reboot to fix this:

```shell
sudo launchctl config user path /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

## Wget

Tools like drush require wget. Install it using homebrew:
 
```shell
brew install wget
```

> Note: This will also install openssl. 

## pkg-config

pkg-config is required to install some PHP extensions. Install it up-front:

```shell
brew install pkg-config
```

## Update GIT to latest version

Homebrew has a more recent version of Git.

```shell
brew install git
```

## OpenSSL

Install OpenSSM:

```shell
brew install openssl
```

### GNU patch

There is a problem when applying patches on MacOS Ventura, installing GNU patch
fixes this issue;

```shell
brew install gpatch
```

---

* [Next : MariaDB](./MariaDB.md)
* [Overview](../README.md)
