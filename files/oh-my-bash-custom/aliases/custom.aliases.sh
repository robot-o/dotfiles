# Add your own custom alias in the custom/aliases directory. Aliases placed
# here will override ones with the same name in the main alias directory.

# tmux
alias tm='tmux'
alias tml='tmuxp load -y'
alias tmlw='tmuxp load -d work_website && tmuxp load -y work_internal' 
alias tmlww='tmuxp load -y work_website '
alias tmlwi='tmuxp load -y work_internal'

# git
alias gst='git status'
alias glog='git log --oneline --color --graph'
alias glogv='git log --pretty --color --graph'
alias ga='git add'
alias gaa='git add -A'
alias gaacm='gaa && git commit -m'
alias gaacmp='gaa && git commit && git push'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gacm='git commit -a -m'
alias gp='git pull'
alias gps='git push'
alias gitfucked='git reset --hard && git clean -xdf'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gds='git diff --staged'
alias gdsw='git diff --staged --word-diff'
alias gsm='git commit -S -m'
alias gus='git reset HEAD'
alias gwc='git whatchanged'

# docker
alias dk='docker'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dkpsaq='docker ps -aq'
alias dkrm='docker rm'
alias dkk='docker kill'
alias dkp='docker prune'
alias dkr='docker run'
alias dkrit='docker run -it'
alias dkrrit='docker run --rm -it'
alias dke='docker exec'
alias dkeit='docker exec -it'
alias dkwipe='docker kill $(docker ps -aq) ; docker rm $(docker ps -aq)'

alias dkvls='docker volume ls'
alias dkvlsq='docker volume ls -q'
alias dkvlsa='docker volume ls -a'
alias dkvlsaq='docker volume ls -aq'
alias dkvrm='docker volume rm'

alias dkils='docker image ls'
alias dkilsq='docker image ls -q'
alias dkilsa='docker image ls -a'
alias dkilsaq='docker image ls -aq'
alias dkirm='docker image rm'

alias dkc='docker-compose'
alias dkcp='docker-compose ps'
alias dkcu='docker-compose up'
alias dkcud='docker-compose up -d'
alias dkcudl='docker-compose up -d && docker-compose logs'
alias dkcudlf='docker-compose up -d && docker-compose logs -f'
alias dkcl='docker-compose logs'
alias dkclf='docker-compose logs -f'

alias dkm='docker-machine'
alias dkms='docker-machine ssh $DOCKER_MACHINE_NAME'
alias dkma='docker-machine active'
alias dkml='docker-machine ls'

# kubectl
alias kc='kubectl'
alias kca='kubectl apply -f'
alias kcgn='kubectl get nodes'
alias kcgp='kubectl get pods --all-namespaces'

# yay
alias yays='yay -S'
alias yayr='yay -Rs'
alias yolo='yay -Syu --noconfirm'

# ansible
alias a='ansible'
alias av='ansible-vault'
alias ag='ansible-galaxy'
alias ap='ansible-playbook'

# directories
alias cdp='cd ~/projects/personal'
alias cdw='cd ~/projects/work/revvis'
alias cdpinfra='cdp && cd infra'
alias td='pushd $(mktemp -d)'
alias pd='popd'

# aliases
alias aq='alias | grep'
alias ae='vim ~/.oh-my-bash/custom/aliases/custom.aliases.sh'
alias brce='vim ~/.bashrc'
alias i3e='vim ~/.config/i3/config'

# tools
alias c='code'
alias ch='code .'
alias tf='terraform'
alias skpc='ssh-keygen -p -f'
alias venva='source bin/activate'
alias v='nvim'

# misc
alias startcapture='gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0'
alias ffw='firefox -P "work" > /dev/null 2>&1 & disown'
alias ffww='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe -P "work" > /dev/null 2>&1 & disown'
alias mode_audio_docked='pacmd unload-module module-suspend-on-idle'
alias mode_audio_portable='pacmd load-module module-suspend-on-idle'
alias showlogs='sudo journalctl -p 3 -xb'
alias rf='rm -rf'
alias fcheck='watch -n 1 grep \"cpu MHz\" /proc/cpuinfo'
alias pcheck='cpupower frequency-info'
