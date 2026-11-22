#!/bin/sh

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

gh auth status || gh auth login

ansible-playbook -e dryrun=True ansible/site.yaml "$@"
