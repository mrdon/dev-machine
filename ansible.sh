#!/usr/bin/env bash
set -x
if ! which ansible-playbook > /dev/null; then 
	sudo apt remove ansible -y
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible -y
fi

if [ -z "$1" ];
then
    : # $1 was not given
    ansible-playbook -i "localhost," -c local playbook.yml --ask-become-pass
else
    : # $1 was given
    ansible-playbook -i "localhost," -c local playbook.yml --ask-become-pass --start-at-task "$1"
fi
