# Add new Apache vhost

Vhost configuration is stored in the `/Volumes/webdev/www/_apache/vhosts`
directory.

## Create a new vhost

Adding a new vhost can be done by creating a copy of one of the templates and 
filling in the specific variables.

There are 2 templates available:

* `___.http.conf-EXAMPLE` : Example for a vhost accessible over http://
* `___.https.conf-EXAMPLE` : Example for a vhost accessible over https://

Create a new vhost by making a copy of one of the two templates:

```bash
cp /Volumes/webdev/www/_apache/vhosts/___.http.conf-EXAMPLE /Volumes/webdev/www/_apache/vhosts/foo.bar.dev
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

  ServerName	NAME-OF-THE-PROJECT.dev
  # Change the DocumentRoot to the root path of your project.
  # Do not add a trailing / to the path.
  DocumentRoot /Volumes/webdev/www/NAME-OF-THE-PROJECT.dev/web
  
  # Change the Directory to the root path of your project.
  # Do not forget to add the trailing / to the path.
  <Directory /Volumes/webdev/www/NAME-OF-THE-PROJECT.dev/web/> 
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
  ErrorLog /Volumes/webdev/www/_apache/log/NAME-OF-THE_PROJECT.dev-http-error.log
  LogLevel warn
  CustomLog /Volumes/webdev/www/_apache/log/NAME-OF-THE_PROJECT.dev-http-access.log combined 
</VirtualHost>
```

Restart Apache after adding a new vhost:

```bash
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
::1             NAME-OF-THE_PROJECT.dev
127.0.0.1       NAME-OF-THE_PROJECT.dev
```

> **IMPORTANT**
>
> Do not use .local for your local domains. The DNS lookup takes extra time and 
> slows down loading the pages!
