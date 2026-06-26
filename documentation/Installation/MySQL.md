# MySQL

MySQL Server is available for installation on macOS (formerly Mac OS X) via 
the Homebrew package manager.

MysqlDB Server is available as a Homebrew "bottle", a pre-compiled package. 
This means you can install it without having to build from source yourself. 
This saves time.

## Installation

Install MySQL with Homebrew:

```shell
brew install mysql
```

## Configuration

We change the default MySQL configuration. This will:

- Set the location of the sock file.
- Set port to 3306 and allow only local connections.
- Set the proper `transaction-isolation` value as requested by Drupal.
- Set the proper `innodb_flush_log_at_trx_commit` value to avoid cache-race
  issues.

The following is a single, multi-line command. Copy and paste the entire 
block at once:

```shell
cat >> $(brew --prefix)/etc/my.cnf <<'EOF'

# START HAMMP
socket = /tmp/mysql.sock

[mysqld]
socket = /tmp/mysql.sock
port = 3306
bind_address = 127.0.0.1
max_connections = 150
transaction-isolation = READ-COMMITTED
innodb_flush_log_at_trx_commit = 2
# END HAMMP
 
EOF
```

## Start MySQL

Start MySQL with the Homebrew command. This will also register the service to
MacOS launchd so it starts after the OS is booted:

```shell
brew services start mysql
```

##	Secure MySQL

By default, MySQL's root user has an empty password from any connection. 

You are advised to run mysql_secure_installation and at least set a password 
for the root user:

```shell
$(brew --prefix mysql)/bin/mysql_secure_installation
```

Answer the questions:

```
NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] <-- Y
New password: <-- Enter password
Re-enter new password: <-- Enter same password
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] <-- Y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] <-- Y
 ... Success!
 

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] <-- Y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] <-- Y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```

In case MySQL does not accept empty password when the installation was just
finished; reset the password with following commands:

Stop the MySQL server:

```shell
brew services stop mysql
```

Use your macbook password when asked:

```shell
sudo mysql
```

Run following query to set the password, replace `newrootpassword` with your
own:

```mysql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'newrootpassword';
```

Logout from MySQL:

```mysql
exit
```

Start the MySQL service:

```shell
brew services start mysql
```

You should now be able to perform the security step from above.

---

* [Next : Apache](./Apache.md)
* [Overview](../README.md)
