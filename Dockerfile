FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        mailutils \
        msmtp \
        msmtp-mta \
        ca-certificates \
    && apt-get clean

# Copy config
COPY msmtprc /etc/msmtprc

# Secure config
RUN chmod 600 /etc/msmtprc

CMD ["bash"]