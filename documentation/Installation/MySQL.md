# MySQL

MySQL Server is available for installation on macOS (formerly Mac OS X) via 
the Homebrew package manager.

MysqlDB Server is available as a Homebrew "bottle", a pre-compiled package. 
This means you can install it without having to build from source yourself. 
This saves time.

## Installation

Install MySQL with Homebrew:

```bash
brew install mysql
```

## Configuration

We change the default MySQL configuration.

This will configure MySQL to allow for the maximum packet size, only 
appropriate for a local or development server. Also, we'll keep each InnoDB 
table in separate files to keep ibdataN-type file sizes low and make 
file-based backups, like Time Machine, easier to manage multiple small files 
instead of a few large InnoDB data files. 

The following is a single, multi-line command. Copy and paste the entire 
block at once:

```bash
cat >> $(brew --prefix)/etc/my.cnf.d/mysqld.cnf <<'EOF'

[mysqld] 
skip-external-locking
key_buffer_size = 96M
max_allowed_packet = 64M
join_buffer_size = 256K
table_open_cache = 512
table_definition_cache = 512
sort_buffer_size = 256K
read_buffer_size = 256K
read_rnd_buffer_size = 256K
net_buffer_length = 2K
thread_stack = 128K
query_cache_size = 16M
thread_cache_size = 4
transaction_isolation = "READ-COMMITTED"
 
EOF
```

```bash
cat >> $(brew --prefix)/etc/my.cnf.d/innodb.cnf <<'EOF'

[innodb]
innodb_file_per_table = 1
innodb_buffer_pool_size = 1G
innodb_log_buffer_size = 4M
innodb_flush_log_at_trx_commit = 2
innodb_thread_concurrency = 8
innodb_flush_method = O_DIRECT
innodb_log_file_size = 32MB

EOF
```

## Start MySQL

Start MySQL with the Homebrew command. This will also register the service to
MacOS launchd so it starts after the OS is booted:

```bash
brew services start mysql
```

##	Secure MySQL

By default, MySQL's root user has an empty password from any connection. 

You are advised to run mysql_secure_installation and at least set a password 
for the root user:

```bash
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

Logout from Mariadb:

```mysql
exit
```

You should now be able to perform the security step from above.

---

* [Next : Apache](./Apache.md)
* [Overview](../README.md)
