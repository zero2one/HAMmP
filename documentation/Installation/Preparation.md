# Preparation

## Create case sensitive partition

AMP stacks are mostly hosted on Linux servers. Linux has a case sensitive 
file system, the default OS X/macOS filesystem is not case sensitive.

To have an environment that is a close to projects live servers, we create a 
separate case sensitive partition.

Since MacOS we can create an APFS volume that shares the diskspace of the main
partitition.

> **Note** : This step is optional.

* Open the Disk Utility (Applications > Utilities > Disk Utility)
  ![Disk Utility](./media/preparation-disk-1-utility.png)
* Select the Main harddisk (Macintosh HD).
* Click on "+ Volume"
* Give the new volume the name `webdev` and select `APFS (Case-sensitive)` as
  the volume format.
  ![Disk Utility](./media/preparation-disk-2-new-partition.png)
* Click on Add to apply the changes. The volume will be added.
  ![Disk Utility](./media/preparation-disk-3-done.png)

We will use that partition for storing the Apache's vhosts.

## Install Xcode Command line tools

We need command line tools to compile and install custom PHP plugins.

We need to have Xcode Command line toolsinstalled to have the necessary tools. 

Run the following command to only install the Xcode essentials including the 
Command line tools:

```bash
xcode-select --install
```

> **Note** : Installing Xcode essentials is done trough the Software Updates
> interface (App store).

---

* [Next : Homebrew](./Homebrew.md)
* [Overview](../README.md)
