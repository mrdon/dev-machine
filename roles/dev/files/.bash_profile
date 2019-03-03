# Slightly modified from: https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt

# Show current git branch in command line
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "