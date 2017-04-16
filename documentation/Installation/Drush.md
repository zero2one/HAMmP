# Drush
This describes how to setup Drush on a Mac.

Drush is a command line shell and Unix scripting interface for Drupal, a 
veritable Swiss Army knife designed to make life easier for those of us who 
spend some of our working hours hacking away at the command prompt.

More info: https://github.com/drush-ops/drush


## Requirements
* [Composer](./Composer.md) : 
  We are installing Drush trough composer, make sure that Composer is installed 
  globally.
* [wget](./Homebrew.md#Wget) : Drush uses wget to get packages from the 
  internet.


## Installation
Install Drush (8) globally using composer:

```bash
$ composer global require drush/drush
```

Drush is installed!


## Commands
Overview of available commands:

```bash
$ drush help
```


## Update Drush
We got Drush from GitHub we can upgrade it anytime to the latest version:

```bash
$ composer global update
```


## Local drush configuration
You can set or override drush configuration.
Do this by creating a .drush folder within your home folder (if it does not 
already exists):

```bash
$ mkdir ~/.drush
```

Create (or edit) the drush config file:

```bash
$ vi ~/.drush/drushrc.php
```

Add following config (as you desire):

### Prevent SVN related errors while using drush dl command or using drush make
In some installations, SVN error notices are shown while downloading modules or 
themes ("sh: line 1: 11912 Trace/BPT trap: 5       svn info…").

Source: http://forums.zend.com/viewtopic.php?f=8&t=107973#p202868

You can prevent this by adding the following line as first line in your drush 
settings (drushrc.php):

```php
// Fix the svn error in CLI.
putenv("DYLD_LIBRARY_PATH=''");
```

### Set the environment variable
You can set an environment variable for your vhosts. Drush is run trough cli 
and does not know about the vhost settings.

You can set the environment variable in the drushrc.php file:

```php
// Set the development environment.
$_SERVER['APPLICATION_ENV'] = 'development';
```

### Exclude the data of certain tables during drush sql-dump commands
When you run drush sql-dump commands, by default all tables and their data are 
dumped. This includes the data in the cache tables.

You can ignore the data by default by adding the table name to the 
structures-only settings in the drushrc.php file:

```php
// Ignore the data in these tables, but keep the table structures. 
// Make sure to update the list when new cache tables are added.
$options['structure-tables']['common'] = array(
  'apachesolr_attachments_files',
  'cache',
  'cache_admin_menu',
  'cache_apachesolr',
  'cache_block',
  'cache_bootstrap',
  'cache_commerce_shipping_rates',
  'cache_field',
  'cache_filter',
  'cache_form',
  'cache_image',
  'cache_libraries',
  'cache_media_xml',
  'cache_menu',
  'cache_page',
  'cache_path',
  'cache_rules',
  'cache_token',
  'cache_update',
  'cache_views',
  'cache_views_data',
  'history',
  'search_dataset',
  'search_index',
  'search_node_links',
  'search_total',
  'sessions',
  'watchdog',
);
 
// Use the list of cache tables above.
$options['structure-tables-key'] = 'common';
```

## Useful extra commands
Add extra commands that are handy during development:

### Drush language
Commands to switch and manage the languages of a Drupal installation.
See [drush_language on d.o.](https://www.drupal.org/project/drush_language).

```bash
$ cd ~
$ drush dl drush_language
```



---
* [Next : Drush](./PHPUnit.md)
* [Overview](../README.md)
