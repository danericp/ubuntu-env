#!/bin/bash

echo "# Custom DevOps Prompt" >> ~/.bashrc
echo 'export PS1="\[\e[31m\][DOCKER]\[\e[0m\] \u@\h:\w\$ "' >> ~/.bashrc
echo 'trap '\''echo "[preexec] $BASH_COMMAND"'\'' DEBUG' >> ~/.bashrc
# echo 'PROMPT_COMMAND='\''echo "[precmd]"'\''' >> ~/.bashrc