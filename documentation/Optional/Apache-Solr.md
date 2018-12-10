# Apache Solr

## Install Apache Solr

The currently stable version of Search API Solr supports Solr upon version
6.x. Homebrew has by default only version 7.x.

Install solr by using a custom gist:

```bash
brew instal https://gist.github.com/magnusvk/0df494187f5bed7029540e647a7f7d47/raw/6d74a0ba641a726786197202e22485c4b6ba41c7/solr.rb
```

You need to start/stop Solr by default manually:

```bash
solr start
solr stop
```

Or you can run following command to make Solr auto start on boot:

```bash
brew services start solr
```

You can access he Web GUI by browsing to 
[http://localhost:8983](http://localhost:8983).

## Create a new core (Solr 6)

> Note : Solr must be running to create a core trough command line. This because
> it uses the web API for it.

Creating a new core in Solr is very simple:

```bash
solr create -c CORE_NAME
```
   
The new core will be created in `/usr/local/opt/solr/server/solr/CORE_NAME`.
   
This is also the directory where the config files are located.

### Log files location

Open the Solr admin interface dashboard to see log location: 
[http://localhost:8983/solr/#/](http://localhost:8983/solr/#/).

![Log location](./media/ApacheSolr-logs.png)
