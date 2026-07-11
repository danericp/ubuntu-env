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
        git \
        tree \
        vim \
    && apt-get clean

# # Append custom prompt + hooks to .bashrc
# RUN echo && \
#     echo '\n# Custom prompt' >> /root/.bashrc && \
#     echo 'export PS1="\[\e[31m\][DOCKER]\[\e[0m\] \u@\h:\w\$ "' >> /root/.bashrc && \
#     echo 'trap '\''echo "[preexec] $BASH_COMMAND"'\'' DEBUG' >> /root/.bashrc && \
#     # echo 'PROMPT_COMMAND='\''echo "[precmd] Ready"'\''' >> /root/.bashrc && \
#     echo

# Copy config
COPY msmtprc /etc/msmtprc
# Copy customized prompt script
COPY custom_bashrc.sh /tmp/

# Secure config
RUN chmod 600 /etc/msmtprc
# Run customized prompt script
RUN bash /tmp/custom_bashrc.sh && rm /tmp/custom_bashrc.sh

CMD ["/bin/bash"]