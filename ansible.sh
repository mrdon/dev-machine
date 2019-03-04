#!/usr/bin/env bash

if ! which ansible-playbook > /dev/null; then 
	sudo apt remove ansible -y
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install ansible -y
fi

USER_VARS_FILE="user-vars.yml"
if [ ! -f ${USER_VARS_FILE} ]; then
    echo -n "Enter your display name: "
    read display_name

    echo -n "Enter your email address: "
    read email

    username=`whoami`
    playbook_dir=`pwd`
    cat > ${USER_VARS_FILE} << EOF1
user: $username
display_name: $display_name
email: $email
playbook_dir: $playbook_dir
EOF1
fi

if [ -z "$1" ];
then
    : # $1 was not given
    ansible-playbook -i "localhost," -c local playbook.yml --ask-become-pass
else
    : # $1 was given
    ansible-playbook -i "localhost," -c local playbook.yml --ask-become-pass --start-at-task "$1"
fi
