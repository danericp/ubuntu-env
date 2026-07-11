# Ubuntu Dev Environment

An Ubuntu-based test environment, containing essential development packages for personal development.
This environment has been developed, tested and running inside Windows.

## Table of Contents

- [Features](#features)
- [Pre-Requisistes](#pre-requisites)
- [Setup Instructions](#setup-instructions)
- [References](#references)

## Features

| Feature | Description |
|-|-|
| Ubuntu Environment | Version 22.04@sha256:0d779ea97881505f5ef0039336ee85edba27519bdba968c284c86ee066a973c8 |
| MSTP | For emailing using mail, mailx and sendmail |
| Prompt | Customized for better terminal experience |
| Mailing | Uses Gmail for SMTP relay |

## Pre-Requisites

- For Gmail SMTP relay, you will need to [enable 2FA on your Google account](https://myaccount.google.com/security) and then [Generate App Password](https://myaccount.google.com/apppasswords). Use App Password, not your real password.

## Setup Instructions

1. [Enable 2FA on your Google account](https://myaccount.google.com/security)
2. [Generate App Password](https://myaccount.google.com/apppasswords).
3. Edit msmtprc file. Change email and password. Use App Password, not your real password.
```
from           XXX@gmail.com
user           XXX@gmail.com
password       XXX
```
4. Build the Image
```docker-compose up --build -d```
5. Execute the newly container interactive terminal
```docker exec -it ubuntu-dev bash```

## References

| Link |
|-|
| [index : cloud-images/+oci/ubuntu-base](https://git.launchpad.net/cloud-images/+oci/ubuntu-base/tree/oci/index.json?h=refs/tags/dist-jammy-amd64-20260627-01085b33&id=01085b3371ecd07b72cb903983ce84e6a9ba89f0) |
| [Docker Hub - ubuntu](https://hub.docker.com/_/ubuntu) |