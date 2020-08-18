# How to create a trusted self-signed certificate

SOURCE : 
  https://deliciousbrains.com/https-locally-without-browser-privacy-errors/

## Create self-signed certificate

Now when creating a self-signed certificate, we need to provide a configuration
file to OpenSSL and define the SAN in that configuration file. 

Our command becomes:

```bash
openssl req -config domain.test.conf -new -sha256 -newkey rsa:2048 \
  -nodes -keyout domain.test.key -x509 -days 365 \
  -out domain.test.crt
```

For the domain.test.conf configuration file, I just used the one from Stack
Overflow linked in the Chromium comment I mentioned earlier.

The only change I made was replacing the `DNS.1 = example.com` line with
`DNS.1 = domain.test` and removed the rest of the DNS lines underneath it. 

Here’s the full config with comments removed and formatting cleaned up:

```
[ req ]

default_bits        = 2048
default_keyfile     = server-key.pem
distinguished_name  = subject
req_extensions      = req_ext
x509_extensions     = x509_ext
string_mask         = utf8only

[ subject ]

countryName                 = Country Name (2 letter code)
countryName_default         = BE

stateOrProvinceName         = State or Province Name (full name)
stateOrProvinceName_default = Flanders

localityName                = Locality Name (eg, city)
localityName_default        = Oudenaarde

organizationName            = Organization Name (eg, company)
organizationName_default    = Serial Graphics BVBA

commonName                  = Common Name (e.g. server FQDN or YOUR name)
commonName_default          = domain.test

emailAddress                = Email Address
emailAddress_default        = peter@serial-graphics.com

[ x509_ext ]

subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid,issuer

basicConstraints       = CA:FALSE
keyUsage               = digitalSignature, keyEncipherment
subjectAltName         = @alternate_names
nsComment              = "OpenSSL Generated Certificate"

[ req_ext ]

subjectKeyIdentifier = hash

basicConstraints     = CA:FALSE
keyUsage             = digitalSignature, keyEncipherment
subjectAltName       = @alternate_names
nsComment            = "OpenSSL Generated Certificate"

[ alternate_names ]

DNS.1 = domain.test.key
```

## Installing the Certificate

Next you’ll need to install the certificate into Nginx, Apache, or whatever web
server you’re using. I’m not going to cover that here as it really depends on
your environment.

In my case, because I’m using an Ubuntu server I just follow the instructions
from our Hosting WordPress Yourself series. 

If you’re using MAMP, you select the certificate and key files using the UI as
shown in the screenshot above.

Once you’ve updated your web server’s config and restarted it (don’t forget to
restart it), loading the site will still give you a browser privacy error:

![Screenshot of Chrome browser with security warning](https://cdn.deliciousbrains.com/content/uploads/2017/04/27091458/Screen-Shot-2017-04-26-at-11.19.59-AM-1540x1265.png)

You’ll notice that it’s now a different error: `ERR_CERT_AUTHORITY_INVALID`.
The browser doesn’t trust the certificate because we self-signed it instead of
getting it from a certificate authority. However, we can add the certificate to
our macOS Keychain and indicate that the certificate should always be trusted.

## Adding the Certificate to macOS Keychain

In Chrome, open the dev site you’ve configured to use the certificate

* Press Cmd-Alt-I to open Developer Tools
* Click the Security tab
* Click the View certificate button
* You should end up with a screen that looks like this:

![Screenshot of Chrome browser viewing insecure self-signed certificate](https://cdn.deliciousbrains.com/content/uploads/2017/04/27093729/Screen-Shot-2017-04-27-at-9.32.39-AM-1540x1019.png)

Now, drag the little certificate icon into a folder in the Finder app.

![Animated gif of dragging the certificate from Chrome into the Finder](https://cdn.deliciousbrains.com/content/uploads/2017/04/27101408/drag-certificate.gif)

A certificate file will be created in that folder. Double click on the file.
If you have multiple keychains like I do, you might get a window like this:

![Screenshot of MacOS Add Certificates dialog box for adding a new certificate to a keychain](https://cdn.deliciousbrains.com/content/uploads/2017/04/27101641/Screen-Shot-2017-04-27-at-10.15.22-AM.png)

Click “Add”. If you only have one keychain, your certificate might be added to
your keychain without a prompt. Regardless if you have to accept a prompt or
not, a Keychain Access window should show up. Search for your certificate:

![Screenshot of MacOS Keychain Access with newly added certificate](https://cdn.deliciousbrains.com/content/uploads/2017/04/27102513/Screen-Shot-2017-04-27-at-10.24.52-AM-1540x1039.png)

Double click on it. A window will open with the certificate details. Expand the
Trust section. Change the “When using this certificate:” select box to
“Always Trust”.

![Screenshot of self-signed certificate added to keychain and set to Always Trust](https://cdn.deliciousbrains.com/content/uploads/2017/04/27102749/Screen-Shot-2017-04-27-at-10.27.20-AM.png)

Close the certificate window. It will ask you to enter your password (or scan
your finger), do that. Now visit your dev site again.

![Screenshot of Chrome browser showing a secure connection using the new self-signed certificate](https://cdn.deliciousbrains.com/content/uploads/2017/04/27104213/secure-dev-site.png)
