# MariaDB Back-up

It can be handy to create a backup of each database in one go. Following 
oneliners by [Mattias Geniar](https://ma.ttias.be/) help you to create these
dumps.

These are very simple one-liners that come in handy when you're migrating from
server-to-server (or from workstation-to-workstation):

## Dump databases to separate files

To take a back-up, run the mysqldump tool on each available database.

```bash
mysql -N -e 'show databases' | while read dbname; do mysqldump --complete-insert --single-transaction "$dbname" > "$dbname".sql; done
```

The result is a list of all your database files, in your current working
directory, suffixed with the .sql file extension.

```bash
ls -alh *.sql
```

```
-rw-r--r-- 1 root root 44M Aug 24 22:39 db1.sql
-rw-r--r-- 1 root root 44M Aug 24 22:39 db2.sql
```

If you want to write to a particular directory, like `/var/dump/databases/`, you
can change the output of the command like this:

```bash
mysql -N -e 'show databases' | while read dbname; do mysqldump --complete-insert --single-transaction "$dbname" > /var/dump/databases/"$dbname".sql; done
```

## 	Dump databases to compressed files

If you want to compress the files, as you're taking them, you can run either
gzip or bzip on the resulting SQL file:

```
$ mysql -N -e 'show databases' | while read dbname; do mysqldump --complete-insert --single-transaction "$dbname" > "$dbname".sql; [[ $? -eq 0 ]] && gzip "$dbname".sql; done
```

The result is again a list of all your databases, but gzip'd to save diskspace.

This can significantly save you on diskspace at the cost of additional CPU
cycles while taking the back-up.

## Import database dump files

Now that you have a directory full of database files, with the database name in 
the SQL file, how can you import them all again?

The following for-loop will read all files, strip the ".sql" part from the
filename and import to that database.

> **Warning**: this overwrites your databases, without prompting for
> confirmation. Use with caution!

```bash
for sql in *.sql; do dbname=${sql/\.sql/}; echo -n "Now importing $dbname ... "; mysql $dbname < $sql; echo " done."; done
```

The output will tell you which database has been imported already.

```
Now importing db1 ... done.
Now importing db2 ... done.
```

---

## Source

* https://ma.ttias.be/mysql-back-up-take-a-mysqldump-with-each-database-in-its-own-sql-file/#ap
