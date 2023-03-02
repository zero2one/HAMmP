# Solr

## Downgrade Solr to 8.x

The latest stable version of Solr is 9.x. This caused Solr 8.x to be removed
from the Homebrew taps.

This describes how to setup a local Solr 8.x tap from Homebrew history and use
it to downgrade Solr.

First remove Solr 9.x:

```shell
solr stop
brew remove solr 
```

Create a local tap of the old Solr version from Homebrew history:

```shell
brew tap-new $USER/solr
brew extract --version=8.11 solr $USER/solr 
```

Install this version:

```shell
brew install $USER/solr/solr@8.11
```

Start the new Solr version:

```shell
solr start
```
