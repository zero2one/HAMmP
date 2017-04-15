# Preparation

## Create case sensitive partition
AMP stacks are mostly hosted on Linux servers. Linux has a case sensitive 
file system, the default OS X/macOS filesystem is not case sensitive.

To have an environment that is a close to projects live servers, we create a 
separate case sensitive partition.

> **Note** : This step is optional.

*	Open the Disk Utility (Applications > Utilities > Disk Utility)
*	Select the Main harddisk, Open the Partition tab.
*	Resize the "Macintosh HD" partition until you have enough space for web 
  development.
*	Create a new partition with the free disk space.
*	Give it the name "webdev", select "Mac OS Extended (case-sensitive, 
  Journaled)" as the file system.
*	Click on Apply to apply the changes. The Macintosh HD partition will be 
  resized and the new partition will be added.

> TODO : Add picture here!

We will use that partition for storing the Apache's vhosts.



## Install Xcode
We need command line tools to compile and install custom PHP plugins.

We need to have Xcode installed to have the necessary tools. You can install 
Xcode for free trough the App Store.

Open the App store, search for Xcode and install the application.

> TODO: Add picture here!


 
## Install Homebrew
Install homebrew as described in their documentation:

```bash
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Make sure to add the Homebrew's sbin directory to the path:

```bash
$ echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
```


## OpenSSL
OpenSSL is needed for PHP 5.6 (source: http://akrabat.com/ssl-certificate-verification-on-php-5-6/).

```bash
$ brew install openssl
```



## Wget
Tools like drush require wget. Install it using homebrew:
 
```bash
$ brew install wget
```
