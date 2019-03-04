Runs ansible, provisioning local machine with dev tools and setup.

## Requires

Just a Linux box with apt available. Ansible will be automatically installed if missing.

## Usage

Simply run `./ansible.sh` and follow the prompts (for the first time only).

**WARNING: This *will* install and modify packages on your machine. Read through the files in `roles/` so you know what will happen.**

### One Liner

`git clone git@github.com:mrdon/dev-machine.git && cd dev-machine && ./ansible.sh`
