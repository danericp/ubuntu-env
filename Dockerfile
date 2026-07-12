FROM ubuntu:22.04@sha256:0d779ea97881505f5ef0039336ee85edba27519bdba968c284c86ee066a973c8

# Disable Interactive process in background
ENV DEBIAN_FRONTEND=noninteractive

# Instal MSMTP Packages
RUN apt-get update && \
    apt-get install -y \
        mailutils \
        msmtp \
        msmtp-mta \
        ca-certificates \
    && apt-get clean

# Install Essential Packages
RUN apt-get update && \
    apt-get install -y \
        bash \
        curl \
        git grep \
        tree \
        vim \
    && apt-get clean

# Install Developer Packages
RUN apt-get update && \
    apt-get install -y \
        postgresql-client \
        python3 python3-pip python3-venv \
    && apt-get clean

# Copy config
COPY init/msmtprc /etc/msmtprc
# Copy customized prompt script
COPY init/custom_bashrc.sh /tmp/

# Secure config
RUN chmod 600 /etc/msmtprc
# Run customized prompt script
RUN bash /tmp/custom_bashrc.sh && rm /tmp/custom_bashrc.sh

CMD ["/bin/bash"]