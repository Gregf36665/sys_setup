PATH=$PATH:/usr/local/bin:/opt/local/bin
PATH=$PATH:/Applications/ngspice/bin

alias grep="grep --color"

# shopt -s nocaseglob # make globbing case-insensitive
# To undo use shopt -u nocaseglob
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

# Create better display of git tags
alias gtag='git for-each-ref --format="%(refname:short) %(taggerdate) %(subject) %(body)" refs/tags | sort -V'
