# Redis
By using Homebrew, you greatly reduce the cost of setting up and configuring 
the development environment on Mac OS X.

## Installation
Let’s install Redis for the good.

```bash
$ brew install redis
```

After installation, you will see some notification about some caveats on 
configuring. Just leave it and continue to following some tasks on this article.



## Launch Redis on computer starts.
Register Redis to the Launch Agents:

```bash
$ ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
```

Start Redis server via “launchctl”.

```bash
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
```

Start Redis server using configuration file.

```bash
$ redis-server /usr/local/etc/redis.conf
```

Unregister Redis autostart on computer start.

```bash
$ launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
```



## Configuration
Location of Redis configuration file.

* `/usr/local/etc/redis.conf`



## Uninstall
Uninstall Redis and its files.

```bash
$ brew uninstall redis
$ rm ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
```



## Package info
Get Redis Brew package information.

```bash
$ brew info redis
```



## Test running server
Test if Redis server is running.

```bash
$ redis-cli ping
```

If it replies “PONG”, then it’s good to go!



## Source
* https://medium.com/@petehouston/install-and-config-redis-on-mac-os-x-via-homebrew-eb8df9a4f298
* https://medium.com/@djamaldg/install-use-redis-on-macos-sierra-432ab426640e
