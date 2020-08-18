# Apache

## What version in use

To know what version of Apache is installed:

```bash
httpd -v
```

## Check Apache configuration

Check apache configuration for any syntax mistakes by running following command:

```bash
httpd -t
```

## Global Apache configuration file

The global config file 

```bash
vi "$(brew --prefix)/etc/httpd/httpd.conf"
```

## Custom config files

Custom config files are located at `/Volumes/webdev/www/_apache/conf.d`. New
file are automatically loaded after a httpd service restart.

```bash
brew services restart httpd
```

## Vhosts

Vhosts are located at `/Volumes/webdev/www/_apache/vhosts`.

## Global Apache logs

```bash
ls -lah "$(brew --prefix)/var/log/httpd"
```

## Access & Error logs for all vhosts

When the vhosts are based on the templates:

```bash
ls -lah /Volumes/webdev/www/_apache/log
```
