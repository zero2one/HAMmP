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

## Know issues

### Apache vhosts not accessible after update/upgrade of MacOS

Some updates/upgrades of MacOS re-enable the Apache server that comes with
MacOS. This blocks accessing the Apache server installed using Homebrew.

If you can stop the build in Apache is is running:

```bash
sudo apachectl stop
```

You will not get this warning when it's running:

```
httpd (pid 1316?) not running
```  

Unload the automatically started build-in apache server:

```bash
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
```

Now restart the apache server that is installed with Homebrew:

```bash
brew services restart httpd
```

---

* [Overview](../README.md)
