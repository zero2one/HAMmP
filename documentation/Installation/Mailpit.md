# Mailpit

Mailpit is a small, fast, low memory, zero-dependency, multi-platform email
testing tool & API for developers.

It acts as an SMTP server, provides a modern web interface to view & test
captured emails, and contains an API for automated integration testing

See https://mailpit.axllent.org/

It receives and stores the mails (temporarily) local and gives you a web 
interface to access them.

## Install Mailpit

Install using homebrew:

```bash
brew install mailpit
```

Start the Mailpit service:

```bash
brew services start mailpit
```

Go to the web based interface [http://127.0.0.1:8025](http://127.0.0.1:8025).

## Configure postfix

We will force PHP to send out email trough sendmail. But just to be sure we 
will set Mailpit as the relayhost of postfix:

```bash
sudo vi /etc/postfix/main.cf
```

Add following line at the end of the config file:

```text
relayhost = 127.0.0.1:1025
```

## Configure PHP

Every PHP version needs to be updated so email are send locally to MailHog 
instead of to real users:

```bash
sed -e 's/;*sendmail_path =.*/sendmail_path = \/usr\/local\/bin\/mailpit sendmail test@test/' -i.bak $(brew --prefix)/etc/php/[VERSION]/php.ini
```

> *Note* : Run the command multiple times and replace [VERSION] by the different
> installed PHP versions (8.3, 8.4, ...).

Restart PHP to activate configuration changes

```bash
sphp 8.4
```

## Source 

* https://mailpit.axllent.org/
* https://formulae.brew.sh/formula/mailpit

---

* [Next : Management](./Management.md)
* [Overview](../README.md)
