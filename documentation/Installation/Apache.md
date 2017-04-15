# Apache

##	Prepare directory
We are using the [newly created partition](./Preparation.md#create-case-sensitive-partition)
as our web root.

Create a www folder on the new partition:

```bash
$ mkdir -p /Volumes/webdev/www
```

Clone the folder structure, configuration & scripts from GitHub in the new 
directory:

```bash
$ git clone https://github.com/zero2one/HAMmP.git /Volumes/webdev/www/_apache
```

You should now have a directory called /Volumes/webdev/www/_apache

> **Note** : Cloning the default folder structure, configuration & scripts to 
> the proper location is very important for the rest of the installation 
> process!



##	Disable build-in Apache
Start by stopping the built-in Apache, if it's running, and prevent it from 
starting on boot. This is one of very few times you'll need to use sudo:

```bash
$ sudo launchctl unload /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
```


## Install Apache
The formula for building Apache is not in the default Homebrew repository 
that you get by installing Homebrew. While we can use the format of brew 
install external-repo/formula, if an external formula relies on another 
external formula, you have to use the brew tap command first.

We need to tap homebrew-dupes because "homebrew-apache/httpd24" relies on 
"homebrew-dupes/zlib":

```bash
$ brew tap homebrew/dupes
```


We'll install Apache 2.4 with the event MPM and set up PHP-FPM instead of 
mod_php:

1. Switching PHP versions is far easier with PHP-FPM and the default 9000 
   port instead of also editing the Apache configuration to switch the 
   mod_php module location.
2. If we're therefore not using mod_php, we don't have to use the prefork MPM 
   and can get better performance with event or worker.

Install Apache 2.4 with the event MPM, and we'll use Homebrew's OpenSSL 
library since it's more up-to-date than OS X's:

```bash
$ brew install -v homebrew/apache/httpd24 --with-brewed-openssl --with-mpm-event
```

In order to get Apache and PHP to communicate via PHP-FPM, we'll install the mod_fastcgi module:

```bash
$ brew install -v homebrew/apache/mod_fastcgi --with-homebrew-httpd24
```

If you encounter problems with pcre just follow the instructions: "_You must 
`$ brew link pcre` before homebrew/apache/mod_fastcgi can be installed_".

To prevent any potential problems with previous mod_fastcgi setups, let's 
remove all references to the mod_fastcgi module (we'll re-add the new version
later):

```bash
$ sed -i '' '/fastcgi_module/d' $(brew --prefix)/etc/apache2/2.4/httpd.conf
```



### Add hostname to Apache configuration
Add the hostname to the Apache configuration:

_Multiline command, copy all at once:_

```bash
$ export SERVERNAME=$(hostname); cat > /Volumes/webdev/www/_apache/conf.d/hostname.conf <<EOF

HostnameLookups Off
ServerName $SERVERNAME
 
EOF
```



## Create SSL certificate
We create 1 certificate that we use for all the vhosts that need an SSL 
configuration:

_Multiline command, copy all at once:_

```bash
$ openssl req \
  -new \
  -newkey rsa:2048 \
  -days 3650 \
  -nodes \
  -x509 \
  -subj "/C=BE/ST=Flanders/L=Heverlee/O=Amplexor/OU=$(whoami)/CN=*.dev" \
  -keyout /Volumes/webdev/www/_apache/include/ssl/private.key \
  -out /Volumes/webdev/www/_apache/include/ssl/selfsigned.crt
```



## Add the custom configuration to Apache
We extend the Apache configuration with custom files. We need to add their 
location to Apache so they are loaded on startup:

_Multiline command, copy all at once:_

```bash
$ cat >> $(brew --prefix)/etc/apache2/2.4/httpd.conf <<EOF
# CUSTOM configuration -----------------------------------------------
Include /Volumes/webdev/www/_apache/conf.d/*.conf
Include /Volumes/webdev/www/_apache/vhosts/*.conf
EOF
```
