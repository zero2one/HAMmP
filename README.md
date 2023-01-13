# Apache - MySQL - (multi) PHP stack with Homebrew

This repository contains a basic file structure and helper scripts to setup and
maintain a local Apache, MariaDb and multiple PHP versions stack on MacOS.

This setup is for MacOS.

All services in the stack are installed with Homebrew.

## What is included

You will end up with:

* Apache 2.4.x
* MariaDB 15.1.x
* One or more PHP versions:
    * PHP 7.4
    * PHP 8.1
    * PHP 8.2
* A script to switch between PHP versions.
* A CLI to start/stop services and to easily gain access to the configuration 
  files.
  
## Documentation

[See the documentation](./documentation/README.md) to install and use the HAMmP
stack.
