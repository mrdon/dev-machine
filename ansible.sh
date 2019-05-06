#!/usr/bin/env bash

if ! which ansible-playbook > /dev/null; then 
    sudo apt install python-pip
    sudo pip install github3.py==1.0.0a4
    sudo apt remove ansible -y
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible -y
fi

VAULT_FILE="$HOME/.dev-machine-vault"
USER_VARS_FILE="vars/user.yml"
if [ ! -f ${USER_VARS_FILE} ]; then
    echo -n "Enter your display name: "
    read display_name

    echo -n "Enter your email address: "
    read email

    echo -n "Enter the vault password: "
    read vault_pwd

    username=`whoami`
    playbook_dir=`pwd`

    echo $vault_pwd > $VAULT_FILE
    chmod 600 $VAULT_FILE
    cat > ${USER_VARS_FILE} << EOF1
user: $username
display_name: $display_name
email: $email
playbook_dir: $playbook_dir
EOF1
fi

# migration

if [ -f user-vars.yml ]; then
    mv -f user-vars.yml vars/user.yml
fi

if [ -z "$1" ];
then
    : # $1 was not given
    sudo ansible-playbook -i "localhost," -c local --vault-id $VAULT_FILE playbook.yml -b --become-user=`whoami`
else
    : # $1 was given
    sudo ansible-playbook -i "localhost," -c local --vault-id $VAULT_FILE playbook.yml -b --become-user=`whoami` --start-at-task "$1"
fi
