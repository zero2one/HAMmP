# Apache

##	Prepare directory

We are using the [newly created partition](./Preparation.md#create-case-sensitive-partition)
as our web root.

Create a www folder on the new partition:

```bash
mkdir -p /Volumes/webdev/www
```

Clone the folder structure, configuration & scripts from GitHub in the new 
directory:

```bash
git clone https://github.com/zero2one/HAMmP.git /Volumes/webdev/www/_apache
```

You should now have a directory called /Volumes/webdev/www/_apache

> **Note** : Cloning the default folder structure, configuration & scripts to 
> the proper location is very important for the rest of the installation 
> process!

## Add the HaMmP bin directory to $PATH

Add the HAmMP bin directory to your `$PATH` environment variable so we can use 
the included bash scripts.

> **Note** : Check first if you already have a .bash_profile file in your home 
directory. If not create a new one!

_Multiline command, copy all at once:_

```bash
cat >> ~/.bash_profile <<EOF

# HAMmP -----------------------------------------------
PATH="/Volumes/webdev/www/_apache/bin:$PATH"

EOF
```

Load the altered `.bash_profile` file:

```bash
source ~/.bash_profile
```

Make sure that the scripts can be executed:

```bash
$ chmod +x /Volumes/webdev/www/_apache/bin/*
```

##	Disable build-in Apache

Start by stopping the built-in Apache, if it's running, and prevent it from 
starting on boot. This is one of very few times you'll need to use sudo:

```bash
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null
```

## Install Apache

The formula for building Apache is not in the default Homebrew repository 
that you get by installing Homebrew. While we can use the format of brew 
install external-repo/formula, if an external formula relies on another 
external formula, you have to use the brew tap command first.

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
brew install -v httpd
```

### Add hostname to Apache configuration

Add the hostname to the Apache configuration:

_Multiline command, copy all at once:_

```bash
export SERVERNAME=$(hostname); cat > /Volumes/webdev/www/_apache/conf.d/hostname.conf <<EOF

HostnameLookups Off
ServerName $SERVERNAME
 
EOF
```

## Create SSL certificate

We create 1 certificate that we use for all the vhosts that need an SSL 
configuration:

_Multiline command, copy all at once, Replace the [variables] with your actual
values:_

```bash
openssl req \
  -new \
  -newkey rsa:2048 \
  -days 3650 \
  -nodes \
  -x509 \
  -subj "/C=BE/ST=[STATE]/L=[CITY]/O=[ORGANISATION]/OU=$(whoami)/CN=*.test" \
  -keyout /Volumes/webdev/www/_apache/include/ssl/private.key \
  -out /Volumes/webdev/www/_apache/include/ssl/selfsigned.crt
```

## Add the custom configuration to Apache

We extend the Apache configuration with custom files. We need to add their 
location to Apache so they are loaded on startup:

_Multiline command, copy all at once:_

```bash
cat >> $(brew --prefix)/etc/httpd/httpd.conf <<EOF
# CUSTOM configuration -----------------------------------------------
Include /Volumes/webdev/www/_apache/conf.d/*.conf
Include /Volumes/webdev/www/_apache/vhosts/*.conf
EOF
```

## Start Apache

Finaly we can restart Apache:

```bash
brew services restart httpd
```

## Test

You should now be able to access your local server:

* http: `http://localhost:8080`
* https: `https://localhost:8443`

## Port fowarding

You may notice that httpd.conf is running Apache on ports 8080 and 8443.

Manually adding ":8080" each time you're referencing your dev sites is no fun, 
but running Apache on port 80 requires root.

The next two commands will create and load a firewall rule to forward port 80 
requests to 8080, and port 443 requests to 8443. The end result is that we 
don't need to add the port number when visiting a project dev site, like 
"http://projectname.dev/" instead of "http://projectname.dev:8080/".

The following command will create the file 
`/Library/LaunchDaemons/co.echo.httpdfwd.plist` as root, and owned by root, 
since it needs elevated privileges:

```bash
sudo bash -c 'export TAB=$'"'"'\t'"'"'
cat > /Library/LaunchDaemons/co.echo.httpdfwd.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
${TAB}<key>Label</key>
${TAB}<string>co.echo.httpdfwd</string>
${TAB}<key>ProgramArguments</key>
${TAB}<array>
${TAB}${TAB}<string>sh</string>
${TAB}${TAB}<string>-c</string>
${TAB}${TAB}<string>echo "rdr pass proto tcp from any to any port {80,8080} -> 127.0.0.1 port 8080" | pfctl -a "com.apple/260.HttpFwdFirewall" -Ef - &amp;&amp; echo "rdr pass proto tcp from any to any port {443,8443} -> 127.0.0.1 port 8443" | pfctl -a "com.apple/261.HttpFwdFirewall" -Ef - &amp;&amp; sysctl -w net.inet.ip.forwarding=1</string>
${TAB}</array>
${TAB}<key>RunAtLoad</key>
${TAB}<true/>
${TAB}<key>UserName</key>
${TAB}<string>root</string>
</dict>
</plist>
EOF'
```

This file will be loaded on login and set up the 80->8080 and 443->8443 port 
forwards, but we can load it manually now so we don't need to log out and back 
in:

```bash
sudo launchctl load -Fw /Library/LaunchDaemons/co.echo.httpdfwd.plist
```

Now we can access the localhost on the default ports:

* http: `http://localhost`
* https: `https://localhost`

> Note : If you can't access the localhost on port 80/443 there is probably
> another service listening on that port. It could be a port forwarded by 
> Docker.

You can check what service is running on port 80 by running the following
command, the service name will be in the first column:

```bash
sudo lsof -nP -i4TCP:80 | grep LISTEN
```

---

* [Next : PHP](./PHP.md)
* [Overview](../README.md)
