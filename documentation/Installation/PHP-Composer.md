# Composer

Composer is a tool for dependency management in PHP. It allows you to declare 
the dependent libraries your project needs and it will install them in your 
project for you.

More info: [https://getcomposer.org](https://getcomposer.org/doc/00-intro.md)

## Installation

This describes ho to install composer globally (available everywhere and for 
everyone on your workstation). You can install composer also locally (per 
project).

Download composer:

```bash
mkdir ~/tmp
cd ~/tmp
curl -sS https://getcomposer.org/installer | php
```

Move it to the global bin directory:

```bash
sudo mv composer.phar /usr/local/bin/composer
```

It is now installed:

```bash
composer --help
```

Make sure Composer's global bin directory is on the system PATH (recommended):

```bash
cat >> ~/.bash_profile <<'EOF'

# Composer -----------------------------------
export PATH="$HOME/.composer/vendor/bin:$PATH"

EOF
```

Reload the profile file to make it active:

```bash
source ~/.bash_profile
```

##	Upgrade composer

You can update composer by running:

```bash
sudo composer self-update
```

##	More information

[See composer website](https://getcomposer.org) for more information and usage.

---

* [Next : Drush](Drupal-Drush.md)
* [Overview](../README.md)
