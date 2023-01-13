# MailHog

Mailhog is an open source project (written in go) we use to avoid sending 
out emails to real users (e.g. when using production data) and to test if 
emails are properly sent out.

See https://github.com/mailhog/MailHog

It receives and stores the mails (temporarily) local and gives you a web 
interface to access them.


## Install MailHog

Install using homebrew:

```bash
brew install mailhog
```

Start the MailHog service:

```bash
brew services start mailhog
```

Go to the web based interface [http://127.0.0.1:8025](http://127.0.0.1:8025).

## Configure postfix

We will force PHP to send out email trough sendmail. But just to be sure we 
will set MailHog as the relayhost of postfix:

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
sed -e 's/;*sendmail_path =.*/sendmail_path = \/usr\/local\/bin\/mailhog sendmail test@test/' -i.bak $(brew --prefix)/etc/php/[VERSION]/php.ini
```

> *Note* : Run the command multiple times and replace [VERSION] by the different
> installed PHP versions (7.4, 8.0, 8.1, ...).

Restart PHP to activate configuration changes

```bash
sphp 8.2
```

## Source 

* https://github.com/mailhog/MailHog
* https://github.com/maijs/homebrew-mailhog
* https://gist.github.com/madalinignisca/55e3cbe1cbd9d3af2daea48b045eeb89

---

* [Next : Management](./Management.md)
* [Overview](../README.md)
