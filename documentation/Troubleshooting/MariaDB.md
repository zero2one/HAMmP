# MariaDB

## What version in use

To know what version of MariaDB is installed:

```bash
mariadb --version
```

## Config file

The MariaDB config file is located at `/usr/local/etc/my.cnf``

## Log file

MariaDB writes its log outputs in:

```bash
ls -lah $(brew --prefix)/var/mysql/
```

## Error: Access denied for user 'root'@'localhost' (using password: YES)

When first trying to run mysql_secure_installation with an empty password, you 
can get an access denied error for user root. To fix this, we have to reset the 
root password:

```bash
brew services stop mariadb
$(brew --prefix mariadb)/bin/mysqld_safe --skip-grant-tables
```

In another terminal window:

```bash
mysql -u root  
```

```mysql
UPDATE mysql.user SET authentication_string=PASSWORD('my-new-password') WHERE User='root';  
FLUSH PRIVILEGES;
\q
```

Restart MariaDB 

```bash
brew services start mariadb
```
