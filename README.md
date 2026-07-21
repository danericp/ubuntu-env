# Ubuntu Dev Environment

An Ubuntu-based test environment, containing essential development packages for personal development.
This environment has been developed, tested and running inside Windows.

## Table of Contents

- [Features](#features)
- [Pre-Requisistes](#pre-requisites)
- [Setup Instructions](#setup-instructions)
- [GMail msmtp](#for-google-mail-msmtp)
- [Microsoft Outlook msmtp](#for-outlook-msmtp)
- [Zoho msmtp](#for-zoho-mail-msmtp)
- ["app" Folder Contents](#app-folder-contents)
- [CLI Commands](#cli-commands)
- [References](#references)

## Features

| Feature | Description |
|-|-|
| Ubuntu Environment | Version 22.04@sha256:0d779ea97881505f5ef0039336ee85edba27519bdba968c284c86ee066a973c8 |
| MSTP | For emailing using mail, mailx and sendmail |
| Database | Uses postgres:18.4 and pgadmin:9.16 for the GUI |
| Prompt | Customized for better terminal experience |
| Mailing | Uses Gmail for SMTP relay |
| App | Added scripts for inserting to PosgreSQL |

## Pre-Requisites

- For Gmail SMTP relay, you will need to [enable 2FA on your Google account](https://myaccount.google.com/security) and then [Generate App Password](https://myaccount.google.com/apppasswords). Use App Password, not your real password.

## Setup Instructions

1. Setup your email msmtp. 

### For Google Mail msmtp

- [Enable 2FA on your Google account](https://myaccount.google.com/security)
- [Generate App Password](https://myaccount.google.com/apppasswords).
- Edit [msmtprc](./init/msmtprc) file. Change email and password. Use App Password, not your real password.
```
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        /var/log/msmtp.log

account        gmail
host           smtp.gmail.com
port           587
from           <email>@gmail.com
user           <email>@gmail.com
password       <App Password>

account default : gmail
```

### For Outlook msmtp

```
# For Outlook MSMTPRC
defaults
auth on
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile /var/log/msmtp.log

# Outlook / Office 365 settings
account outlook
host smtp.office365.com
port 587
user <email>@outlook.com
password "your-password-or-app-password"
from <email>@outlook.com

# Set as default
account default : outlook
```

### For Zoho Mail msmtp

- Go to [Accounts > Security > App Passwords](https://accounts.zoho.in/home#security/app_password) and generate a newly app name and app password.
- Go to your [Mail Account Settings](https://mail.zoho.in/zm/#settings/mailaccounts/) and note down the Server/Host.
- Edit [msmtprc](./init/msmtprc) file using below content. Change the email and password. Use App Password, not your real password.
```
# Set default values for all accounts
defaults
auth             on
tls              on
tls_starttls     on
tls_trust_file   /etc/ssl/certs/ca-certificates.crt
logfile          /var/log/msmtp.log

# Zoho Mail Account
account          zoho
host             <Host>
port             587
from             <Email>@zohomail.in
user             <Email>@zohomail.in
password         <App Password>
```

4. Edit [docker-compose.yml](docker-compose.yml) file. Change the default credentials for postgres and pgadmin.
```
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: secret
      POSTGRES_DB: mydb
```
```
      PGADMIN_DEFAULT_EMAIL: admin@example.com
      PGADMIN_DEFAULT_PASSWORD: admin123
```
5. Build the Image
```docker-compose up --build -d```
```docker-compose up --build -d --force-recreate```
6. Execute the newly container interactive terminal
```docker exec -it ubuntu-dev bash```

## "app" Folder Contents

| App | Description |
|-|-|
| ```./psql_insert_fake_users.sh``` | Compiled scripts for PostgreSQL tb_users setup. |

## CLI Commands

| Command | Description |
|-|-|
| ```psql -h postgres -U admin -d mydb``` | Connect to PostgreSQL. You can change the default credentials in [docker-compose.yml](docker-compose.yml). |
| ```echo -e "To: user@email.com\nSubject: Test Email\n\nThis is the body." \| sendmail -t``` | Test sendmail function |
| ```psql -h postgres -U user -d database -f file.sql``` | Run a file in PostgreSQL |

## References

| Link |
|-|
| [index : cloud-images/+oci/ubuntu-base](https://git.launchpad.net/cloud-images/+oci/ubuntu-base/tree/oci/index.json?h=refs/tags/dist-jammy-amd64-20260627-01085b33&id=01085b3371ecd07b72cb903983ce84e6a9ba89f0) |
| [Docker Hub - ubuntu](https://hub.docker.com/_/ubuntu) |