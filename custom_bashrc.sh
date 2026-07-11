#!/bin/bash

cat << 'EOF' >> ~/.bashrc

f_prompt_custom() {
    NUM_DIRS=$(find . -maxdepth 1 -type d ! -path "." ! -path ".." ! -name ".*" | wc -l | xargs)
    NUM_FILS=$(find . -maxdepth 1 -type f ! -name ".*" | wc -l | xargs)
    NUM_HDIRS=$(find . -maxdepth 1 -type d ! -path "." ! -path ".." -name ".*" | wc -l | xargs)
    NUM_HFILS=$(find . -maxdepth 1 -type f -name ".*" | wc -l | xargs)
    # Customized PROMPT
    export PS1="\[\e[31m\][DOCKER]\[\e[0m\] \[\e[32m\]\u@\h:\w\[\e[0m\]:\[\e[34m\]F=${NUM_FILS},HF=${NUM_HFILS},D=${NUM_DIRS},HD=${NUM_HDIRS}\[\e[0m\]> "
}

EOF

echo "# Custom DevOps Prompt" >> ~/.bashrc
echo 'export PS1="\[\e[31m\][DOCKER]\[\e[0m\] \u@\h:\w\$ "' >> ~/.bashrc
echo 'PROMPT_COMMAND=''f_prompt_custom''' >> ~/.bashrc
# echo 'trap ''f_prompt_custom'' DEBUG' >> ~/.bashrc
# echo 'trap '\''echo "[preexec] $BASH_COMMAND"'\'' DEBUG' >> ~/.bashrc
# echo 'PROMPT_COMMAND='\''echo "[precmd]"'\''' >> ~/.bashrc

echo "# Run Custom Prompt" >> ~/.bashrc
echo "f_prompt_custom" >> ~/.bashrc