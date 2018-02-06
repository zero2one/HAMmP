# Mailcatcher
Mailcatcher is an open source project (written in Ruby) we use to avoid sending 
out emails to real users (e.g. when using production data) and to test if 
emails are properly sent out.

See http://mailcatcher.me/

It receives and stores the mails (temporarily) local and gives you a web 
interface to see them.


## Install Mailcatcher
Install trough Ruby Gems (can take some time)

```bash
$ sudo gem install mailcatcher
```

Run the app:

```bash
$ mailcatcher
```

Test by opening [http://localhost:1080](http://localhost:1080).


## Configure postfix
We will force PHP to send out email trough sendmail. But just to be sure we 
will set mailcatcher as the relayhost of postfix:

```bash
$ sudo vi /etc/postfix/main.cf
```

Add following line at the end of the config file:

```text
relayhost = 127.0.0.1:1025
```

## Configure PHP
Every PHP version needs to be updated so email are send locally to mailcatcher 
instead of to real users:

```bash
$ sed -e 's/;*sendmail_path =.*/sendmail_path = \/usr\/bin\/env catchmail/' -i.bak $(brew --prefix)/etc/php/[VERSION]/php.ini
```

> *Note* : Run the command multiple times and replace [VERSION] by the different
> installed PHP versions (5.6, 7.0, 7.1, ...).

Restart PHP to activate configuration changes

```bash
$ sphp 71
```

## Auto startup mailcatcher
Every time you restart the computer, mailcatcher needs to be restarted.
You can autostart mailcatcher by adding it to the services.

Create the service file:

```bash
$ vi ~/Library/LaunchAgents/me.mailcatcher.plist
```

Add following lines:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>me.mailcatcher</string>
        <key>ProgramArguments</key>
        <array>
            <string>sh</string>
            <string>-i</string>
            <string>-c</string>
            <string>$SHELL --login -c "mailcatcher --foreground"</string>
        </array>
        <key>KeepAlive</key>
        <true/>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
```

Register the service

```bash
$ launchctl load ~/Library/LaunchAgents/me.mailcatcher.plist
```

From now on it will start mailcatcher when the computer is (re)started.

You can stop auto load by de-registering the service:

```bash
$ launchctl unload ~/Library/LaunchAgents/me.mailcatcher.plist
```

Source: https://gist.github.com/sj26/1638617
