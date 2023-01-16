# Mkcert

mkcert is a simple tool for making locally-trusted development certificates. It
requires no configuration.

## Installation

Install the command line tool using Homebrew:

```shell
brew install mkcert
brew install nss # if you use Firefox
```

Create a local Certification Authority:

```shell
mkcert -install
```

This will:

* Created a new local CA 💥
* The local CA is now installed in the system trust store! ⚡️
* The local CA is now installed in the Firefox trust store (requires browser
  restart)! 🦊

Add the CA to the OpenSSL certifications (for PHP). This is needed until support
is added, see https://github.com/FiloSottile/mkcert/issues/199.

```shell
ln -s "$(mkcert -CAROOT)/rootCA.pem" /usr/local/etc/openssl@1.1/certs
/usr/local/opt/openssl@1.1/bin/c_rehash
ln -s "$(mkcert -CAROOT)/rootCA.pem" /usr/local/etc/openssl@3/certs
/usr/local/opt/openssl@3/bin/c_rehash
```

## Usage

This project has created a certifications directory for you, see the
`certifications` directory. Open a terminal window in that directory to create
new certificates:

```shell
cd /Volumes/webdev/www/_apache/certificates
```

Create new certificate for local.example.com:

```shell
mkcert local.example.com
```

To setup a vhost with SSH support see 
[HowTo : Apache vhost](../HowTo/Add-Apache-Vhost.md).

## Source 

* https://github.com/FiloSottile/mkcert

---

* [Next : Management](./Management.md)
* [Overview](../README.md)
