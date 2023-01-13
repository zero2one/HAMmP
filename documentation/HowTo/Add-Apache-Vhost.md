# Add new Apache vhost

Vhost configuration is stored in the `/Volumes/webdev/www/_apache/vhosts`
directory.

## Create a new vhost

Adding a new vhost can be done by creating a copy of one of the templates and 
filling in the specific variables.

There are 2 templates available:

* `___.http.conf-EXAMPLE` : Example for a vhost accessible over http://
* `___.https.conf-EXAMPLE` : Example for a vhost accessible over https://

### HTTP vhost

Create a new vhost by making a copy of one of the two templates:

```bash
cp /Volumes/webdev/www/_apache/vhosts/___.http.conf-EXAMPLE /Volumes/webdev/www/_apache/vhosts/NAME-OF-THE-PROJECT.conf
```

Edit the file and fill in the blanks (indicated with NAME-OF-THE-PROJECT):

* ServerName : the local domain name.
* DocumentRoot : the local path where the default index is located (index.html,
  index.php).
* Directory : the local path where the default index is located (index.html,
  index.php).
* ErrorLog : set the name of the error log the same as the local domain name.
* CustomLog : set the name of the access log the same as the local domain name.

```apacheconfig
<VirtualHost *:8080> 
  ServerAdmin webmaster@localhost
  
  # Change this your local domain name.
  # Don't forget to add it to the /etc/hosts file.

  ServerName http://LOCAL-DOMAIN-FOR-YOUR-PROJECT
  # Change the DocumentRoot to the root path of your project.
  # Do not add a trailing / to the path.
  DocumentRoot /Volumes/webdev/www/NAME-OF-THE-PROJECT/web
  
  # Change the Directory to the root path of your project.
  # Do not forget to add the trailing / to the path.
  <Directory /Volumes/webdev/www/NAME-OF-THE-PROJECT/web/> 
    Options Indexes FollowSymLinks MultiViews
    
    AllowOverride All
    <IfModule mod_authz_core.c>
      Require all granted
    </IfModule>
    <IfModule !mod_authz_core.c>
      Order allow,deny
      Allow from all
    </IfModule>
  </Directory> 
  
  # Change the name of the log files corresponding the domain name.
  ErrorLog /Volumes/webdev/www/_apache/log/NAME-OF-THE_PROJECT-http-error.log
  LogLevel warn
  CustomLog /Volumes/webdev/www/_apache/log/NAME-OF-THE_PROJECT-http-access.log combined 
</VirtualHost>
```

Restart Apache after adding a new vhost:

```shell
brew services restart httpd
```

### HTTPS vhost

First make a new certificate:

```shell
cd /Volumes/webdev/www/_apache/certificates
mkcert LOCAL-DOMAIN-FOR-YOUR-PROJECT
```

Create a new vhost by making a copy of one of the https templates:

```bash
cp /Volumes/webdev/www/_apache/vhosts/___.https.conf-EXAMPLE /Volumes/webdev/www/_apache/vhosts/NAME_OF_YOUR_PROJECT.conf
```

Edit the file and fill in the blanks (indicated with NAME-OF-THE-PROJECT):

```apacheconf
# Redirect all HTTP requests to HTTPS.
<VirtualHost *:8080>
    ServerAdmin webmaster@localhost
    ServerName LOCAL-DOMAIN-FOR-YOUR-PROJECT
    Redirect permanent / https://LOCAL-DOMAIN-FOR-YOUR-PROJECT/
</VirtualHost>

<VirtualHost *:8443>
    ServerAdmin webmaster@localhost
    ServerName LOCAL-DOMAIN-FOR-YOUR-PROJECT

    DocumentRoot "/Volumes/webdev/www/NAME-OF-THE_PROJECT/web"
    <Directory "/Volumes/webdev/www/NAME-OF-THE_PROJECT/web/">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog /Volumes/webdev/www/_apache/log/NAME-OF-THE_PROJECT-error.log
    LogLevel warn
    CustomLog /Volumes/webdev/www/_apache/log/NAME-OF-THE_PROJECT-access.log combined

    SSLEngine On
    SSLProtocol all -SSLv2 -SSLv3
    SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW

    SSLCertificateFile "/Volumes/webdev/www/_apache/certificates/LOCAL-DOMAIN-FOR-YOUR-PROJECT.pem"
    SSLCertificateKeyFile "/Volumes/webdev/www/_apache/certificates/LOCAL-DOMAIN-FOR-YOUR-PROJECT-key.pem"
</VirtualHost>
```

Restart Apache after adding a new vhost:

```shell
brew services restart httpd
```

## Update hosts file

You will not be able to access the new vhost without adding a record to the
hosts file.

Open the /etc/hosts file:

```bash
sudo vi /etc/hosts
```

And add for the domain 2 lines (IPv4 & IPv6):

```
::1        LOCAL-DOMAIN-FOR-YOUR-PROJECT
127.0.0.1  LOCAL-DOMAIN-FOR-YOUR-PROJECT
```

> **IMPORTANT**
>
> Do not use .local for your local domains. The DNS lookup takes extra time and 
> slows down loading the pages!
