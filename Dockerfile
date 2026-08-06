FROM ubuntu:22.04@sha256:0d779ea97881505f5ef0039336ee85edba27519bdba968c284c86ee066a973c8

# Disable Interactive process in background
ENV DEBIAN_FRONTEND=noninteractive

# Define Python and Java versions
ENV JAVA_VERSION=17
ENV PYTHON_VERSION=3.12.10
ENV PYTHON_VERSION_2D=3.12
ENV PYTHON_VERSION_1D=3

# Oracle Instant Client version
ENV ORACLE_IC_VERSION=23.8.0.25.04
ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
ENV PATH=/opt/oracle/instantclient:$PATH

# Copy init Files
COPY init/msmtprc /etc/msmtprc
COPY init/requirements.txt /tmp/
COPY init/setup_bashrc.sh /tmp/

# Instal MSMTP Packages
RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        mailutils msmtp msmtp-mta \
    && apt-get clean

# Install Java (OpenJDK 17 is a stable choice)
RUN apt-get update && \
    apt-get install -y openjdk-${JAVA_VERSION}-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Essential Packages
RUN apt-get update && \
    apt-get install -y \
        alien ansible apt-transport-https \
        bash build-essential \
        ca-certificates cmake coreutils curl \
        dnsutils \
        git gnupg grep \
        htop \
        iputils-ping \
        jq \
        libaio-dev libaio1 libcairo2-dev libssl-dev lsb-release \
        nano net-tools nginx \
        openssh-client \
        pkg-config python3-openssl \
        software-properties-common sudo \
        tar tree tzdata \
        unzip uuid-runtime \
        vim \
        wget \
        zip \
    && apt-get clean

# Install Developer Packages
RUN apt-get update && \
    apt-get install -y \
        postgresql-client \
    && apt-get clean

# Download, extract, configure, and compile Python
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -xf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make -j $(nproc) \
    && make altinstall \
    && cd .. && rm -rf Python-${PYTHON_VERSION}*

# Link the compiled binary so it acts as the default 'python' command
RUN ln -s /usr/local/bin/python${PYTHON_VERSION_2D} /usr/local/bin/python \
    && ln -s /usr/local/bin/pip${PYTHON_VERSION_2D} /usr/local/bin/pip

# Download and Setup Oracle Instant Client Basic Package and SQL*Plus Package
RUN mkdir -p /opt/oracle && \
    wget -O basic.zip \
    https://download.oracle.com/otn_software/linux/instantclient/2380000/instantclient-basic-linux.x64-23.8.0.25.04.zip && \
    wget -O sqlplus.zip \
    https://download.oracle.com/otn_software/linux/instantclient/2380000/instantclient-sqlplus-linux.x64-23.8.0.25.04.zip && \
    unzip -o basic.zip -d /opt/oracle && \
    unzip -o sqlplus.zip -d /opt/oracle && \
    mv /opt/oracle/instantclient_* /opt/oracle/instantclient && \
    rm -f *.zip

RUN echo "/opt/oracle/instantclient" > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig

# Secure config
RUN chmod -f 600 /etc/msmtprc
# Run customized prompt script
RUN bash /tmp/setup_bashrc.sh && \
    rm /tmp/setup_bashrc.sh
# Run Python Package Installation
RUN python -m pip install --upgrade pip
# RUN python -m pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt
# Run Web Server inside /var/www/html
RUN service nginx start

CMD ["/bin/bash"]