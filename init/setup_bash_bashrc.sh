#!/bin/bash

# echo "echo \"\"" >> /etc/bash.bashrc 

# # Fetch current terminal width
# echo "COLUMNS=$(tput cols)" >> /etc/bash.bashrc 
# # Subtract 2 for the corners
# echo "MIDDLE_LENGTH=$((${COLUMNS} - 1))" >> /etc/bash.bashrc 
# # Generate the line using printf
# echo "printf "╔"" >> /etc/bash.bashrc 
# echo "printf '═%.0s' $(seq 1 ${MIDDLE_LENGTH})" >> /etc/bash.bashrc 
# # printf "╗\n"

# echo "echo "║ TEST BANNER"" >> /etc/bash.bashrc 

# echo "printf "╚"" >> /etc/bash.bashrc 
# echo "printf '═%.0s' $(seq 1 $MIDDLE_LENGTH)" >> /etc/bash.bashrc 
# echo "printf "\n"" >> /etc/bash.bashrc 
# # printf "╝\n"

echo "echo \"
██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
\" " >> /etc/bash.bashrc

echo "echo \"Please DO:
> DO use your assigned account and keep your credentials confidential.
> DO use strong passwords and follow the organization's authentication requirements.
> DO protect sensitive, confidential, and proprietary information.
> DO verify commands and files before executing them, especially with sudo or elevated privileges.
> DO report suspicious activity, unauthorized access, or security incidents immediately.
> DO log out when finished, especially on shared systems.
> DO keep software, scripts, and configurations within approved standards.
> DO follow organizational security and data-handling policies.
\" " >> /etc/bash.bashrc

echo "echo \"Please DON'T:
> DON'T share passwords, SSH keys, tokens, or other credentials.
> DON'T access accounts, files, processes, or systems without authorization.
> DON'T attempt to bypass security controls, authentication, or access restrictions.
> DON'T install or run unauthorized software, scripts, or services.
> DON'T modify system configurations without authorization.
> DON'T use this system for illegal, malicious, or unauthorized activities.
> DON'T copy, disclose, or transfer confidential information to unauthorized locations.
> DON'T leave privileged sessions unattended.
> DON'T use another user's account or credentials.
> DON'T assume that activity on this system is private; system activity may be monitored and logged.
\" " >> /etc/bash.bashrc

echo "python --version" >> /etc/bash.bashrc
echo "java --version" >> /etc/bash.bashrc