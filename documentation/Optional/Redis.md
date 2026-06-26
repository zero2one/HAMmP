# Redis
By using Homebrew, you greatly reduce the cost of setting up and configuring 
the development environment on Mac OS X.

## Installation

Install redis and start the server:

```bash
brew install redis
brew services start redis
```

## Configuration

Location of Redis configuration file.

* `$(brew --prefix)/etc/redis.conf`

## Uninstall

Uninstall Redis and its files.

```bash
brew services stop redis
brew uninstall redis
```

## Package info

Get Redis Brew package information.

```bash
brew info redis
```

## Test running server

Test if Redis server is running.

```bash
$ redis-cli ping
```

If it replies “PONG”, then it’s good to go!

## Install the PHP Redis module

Add the PHP module to use the Redis server:

```shell
sphp 8.4 && pie install phpredis/phpredis
sphp 8.5 && pie install phpredis/phpredis
```

---

* [Overview](../README.md)
