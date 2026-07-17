FROM ubuntu:22.04@sha256:0d779ea97881505f5ef0039336ee85edba27519bdba968c284c86ee066a973c8

# Disable Interactive process in background
ENV DEBIAN_FRONTEND=noninteractive

# Instal MSMTP Packages
RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        mailutils msmtp msmtp-mta \
    && apt-get clean

# Install Essential Packages
RUN apt-get update && \
    apt-get install -y \
        bash \
        coreutils curl \
        git grep \
        jq \
        tree tzdata \
        uuid-runtime \
        vim \
    && apt-get clean

# Install Developer Packages
RUN apt-get update && \
    apt-get install -y \
        postgresql-client \
        python3 python3-pip python3-venv \
    && apt-get clean

# Copy init Files
COPY init/msmtprc /etc/msmtprc
COPY init/requirements.txt /tmp/
COPY init/setup_cli.sh /tmp/

# Secure config
RUN chmod 600 /etc/msmtprc
# Run customized prompt script
RUN bash /tmp/setup_cli.sh && \
    rm /tmp/setup_cli.sh
# Run Python Package Installation
RUN python3 -m pip install -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

CMD ["/bin/bash"]