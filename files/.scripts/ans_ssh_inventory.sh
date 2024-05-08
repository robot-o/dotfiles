$(ansible-inventory --host $(ansible-inventory --list | jq -r '.server_status_running.hosts[]' | fzf) | jq -r '"ssh -p " + (.ansible_port|tostring) + " " + .ansible_user + "@" + .ansible_host')
