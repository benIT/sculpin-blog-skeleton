---
title: Configure an apache2 SSL virtual host from a P12 certificate  
categories:
    - linux
    - apache2
tags:

---
[source article](https://www.tbs-certificats.com/FAQ/fr/346.html)

## About PKCS_12

[Wikipedia](https://en.wikipedia.org/wiki/PKCS_12): 

In cryptography, PKCS #12 defines an archive file format for storing many cryptography objects as a single file. It is commonly used to bundle a private key with its X.509 certificate or to bundle all the members of a chain of trust.


## Get certificate and private key from P12 file

    openssl pkcs12 -in file.p12 -out package.pem -nodes
    cp package.pem myapp.domain.fr.key
    cp package.pem myapp.domain.fr.cert

### Extract certificate

Edit `myapp.domain.fr.key` and keep only the certificate section from `-----BEGIN CERTIFICATE-----` to `-----END CERTIFICATE-----`

### Extract private key

Edit `myapp.domain.fr.key` and keep only the certificate section from `-----BEGIN PRIVATE KEY-----` to `-----BEGIN PRIVATE KEY-----`

## Configure your webserver

### Move files    

    mv myapp.domain.fr.cert /etc/ssl/certs/
    mv myapp.domain.fr.key /etc/ssl/private

#### Configure your virtual host

    SSLCertificateFile	/etc/ssl/certs/myapp.domain.fr.cert
    SSLCertificateKeyFile /etc/ssl/private/myapp.domain.fr.key