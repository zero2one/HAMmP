# MariaDb to MySQL

MySQL has an encoding (utf8mb4_0900_ai_ci) who MariaDB not supports.

This guide describes howto switch from MariaDb to MySQL.

## Backup

Backup all of your current databases with mysqldump

```shell
mysqldump -uroot -p --all-databases --flush-logs --master-data=2 > all_databases.sql
```

Within the msyqldump above, make sure you have dumped the mysql.users table. 
Either do this, or dump your mysql table data independently, or make note of
your existing mysql user permissions if you just want to manually add them to
your clean new MySQL server later. If you have a lot of different permissions
setup, you will probably want to migrate them. If you don't have many db users,
you may want to add them manually later so you can get a refresher of how your
user permissions are setup.

Dump your existing mysql table:

```shell
mysqldump -uroot -p mysql > mysql.sql
```

## Uninstall MariaDB

Stop the running server:

```shell
brew services stop mariadb
```

Remove MariaDB:

```shell
brew remove mariadb
brew cleanup
```

## Install MySQL

Install MySQL as [described in the documentation](../Installation/MySQL.md).

## Restore

After installing your new MySQL server, you can restore the mysql database by
executing:

```shell
$ mysql -uroot -p mysql < mysql.sql
```

then make sure to flush privileges for the new user permissions to take effect:

```shell
FLUSH PRIVILEGES
```
