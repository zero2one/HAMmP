# MySQL

## Installation
Install MySQL with Homebrew:

```bash
$ brew install -v mysql
```


## Configuration
Copy the default `my-default.cnf` file to the MySQL Homebrew Cellar directory
where it will be loaded on application start:

```bash
$ cp -v $(brew --prefix mysql)/support-files/my-default.cnf $(brew --prefix)/etc/my.cnf
```

This will configure MySQL to allow for the maximum packet size, only 
appropriate for a local or development server. Also, we'll keep each InnoDB 
table in separate files to keep ibdataN-type file sizes low and make 
file-based backups, like Time Machine, easier to manage multiple small files 
instead of a few large InnoDB data files. 

The following is a single, multi-line command. Copy and paste the entire 
block at once:

```bash
$ cat >> $(brew --prefix)/etc/my.cnf <<'EOF'
 
# General settings.
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
 
# InnoDB specific settings.
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
Now we need to start MySQL using OS X's launchd. This used to be an involved 
process with launchctl commands, but now we can leverage the excellent brew 
services command:

```bash
$ brew tap homebrew/services
$ brew services start mysql
```


##	Secure MySQL
By default, MySQL's root user has an empty password from any connection. 

You are advised to run mysql_secure_installation and at least set a password 
for the root user:

```bash
$ $(brew --prefix mysql)/bin/mysql_secure_installation
```
