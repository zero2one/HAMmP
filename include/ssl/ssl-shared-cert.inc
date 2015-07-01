
# Shared configuration to enable SSL.

SSLEngine On
SSLProtocol all -SSLv2 -SSLv3
SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW

SSLCertificateFile "/Volumes/webdev/www/_apache/include/ssl/selfsigned.crt"
SSLCertificateKeyFile "/Volumes/webdev/www/_apache/include/ssl/private.key"
