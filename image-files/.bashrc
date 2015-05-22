source ~/.git-completion.sh
export ANDROID_HOME=/usr/local/opt/android-sdk
export LANG="en_US.UTF-8"
export PERL_BADLANG="0"
export PAGER=less
export EDITOR=/usr/bin/vim
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/Users/ash/bin:/sbin:$PATH
export SBT_OPTS=-XX:MaxPermSize=256M

export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

if [ -d "~/perl5/perlbrew" ]; then
    source ~/perl5/perlbrew/etc/bashrc
fi


PS1='\[\033[1;31m\]\u@\h\[\033[1;31m\]:\[\033[00m\]\w\[\033[38;5;55m\]$(__git_ps1 " [%s] ")\[\033[1;31m\]\$ \[\033[00m\] '

perl6() {
    docker run -it rakudo-star /bin/bash
}

docker-ssh() {
    docker exec -i -t $1 bash
}

env-file() {
    export $(cat $1 | grep -v ^# | xargs)
}

map2boot2docker() {
    port=$1;
    boot2docker ssh -f -L \*:$port:localhost:$port -N;
}

b2dgo() {
    boot2docker up;
    eval $(boot2docker shellinit);
    map2boot2docker 3001;
    map2boot2docker 5000;
    map2boot2docker 5001;
    map2boot2docker 5002;
    map2boot2docker 5003;
    map2boot2docker 5004;
}

in-stratperl() {
    docker run -ti -v "$PWD:/home/svizra" docker.sdlocal.net/svizra/testing
}

maildev-stratperl() {
    docker run -ti -v "$PWD:/home/svizra" --link 'maildev:maildev' docker.sdlocal.net/svizra/testing
}

fetchcuse() { curl -s http://developerexcuses.com/ | perl -ne '/center.*nofollow.*?>(.*?)<\/a>/ and print "$1\n"'; }

ngoecp() {
    cp $1.yaml ~/src/development/mhc-wa/ngoe/$1-outlet/sessions/
}

uuid() { perl -MSD::RandomToken -E "for ( 1 .. ( '$@' || 10 ) ) { say SD::RandomToken->new }"; }

tt22() { perl -MTemplate -E 'Template->new->process(\*DATA, require $ARGV[0])' "$@" ; }
tt() { perl -MTemplate -E "Template->new->process(\'$@', undef, \$out); say $out"; }
tmouse() { for i in resize-pane select-pane select-window; do tmux set mouse-$i $1; done; }
perlat() { for i in $@; do PATHSEP=: prepend_envvar_at PERL5LIB $i; done; }

prepend_envvar() {
    local envvar=$1
    local pathsep=${PATHSEP:-:}
    eval "local envval=\$(strip_envvar \$$envvar $2)"
    if test -z $envval; then
        eval "export $envvar=\"$2\""
    else
        eval "export $envvar=\"$2$pathsep$envval\""
    fi
    #eval "echo \$envvar=\$$envvar"
}
prepend_envvar_at() {
    cd $2 || return
    prepend_envvar_here $1
    cd - >> /dev/null
}

envvar_contains() {
    local pathsep=${PATHSEP:-:}
    eval "echo \$$1" | egrep -q "(^|$pathsep)$2($pathsep|\$)";
}

strip_envvar() {
    [ $# -gt 1 ] || return;

    local pathsep=${PATHSEP:-:}
    local haystack=$1
    local needle=$2
    echo $haystack | sed -e "s%^${needle}\$%%" \
                   | sed -e "s%^${needle}${pathsep}%%" \
                   | sed -e "s%${pathsep}${needle}\$%%" \
                   | sed -e "s%${pathsep}${needle}${pathsep}%${pathsep}%"
}


prepend_envvar_here() { prepend_envvar $1 $(pwd); }


alias profile='source ~/.bashrc'

export PKG_CONFIG_PATH=~/src/game/protocol_buffers/
export HISTIGNORE="&:[bf]g:exit"
export PERL_CPANM_OPT="--sudo"

### Functions ###

yamldump() {
perl -MData::Dumper::Concise -MYAML -e \
        'print qq("$_" =>\n), Dumper(YAML::LoadFile($_)) for @ARGV' $@
}


### functions ###
yaml2csv() { perl -MYAML::XS -MText::CSV::Slurp -0e 'print Text::CSV::Slurp->new->create(input => Load(<>))'; }

function yaml_to_meta() {
    SD_WSDEFAULTS_PATH=core/conf/ SD_CONF_FILE=~/src/development/deecd/census-2014/default/conf/config.pl /usr/bin/env perl -Ibuild/lib -Icore/lib core/bin/ws-yml-map Meta < $1.yaml
}

function yaml_to_xlsx() {
    SD_WSDEFAULTS_PATH=core/conf/ SD_CONF_FILE=~/src/development/deecd/census-2014/default/conf/config.pl /usr/bin/env perl -Ibuild/lib -Icore/lib core/bin/ws-yml-map -m=$2 Flatten Empty Dump 'XLSX('$1.xlsx')' Null < $1.yaml
}

function yaml_to_keep() {
    SD_WSDEFAULTS_PATH=core/conf/ SD_CONF_FILE=~/src/surveys/development/deecd/census-2013/default/conf/config.pl /usr/bin/env perl -Ibuild/lib -Icore/lib core/bin/ws-yml-map -l
}

function yaml_to_xls_master() {
    SD_WSDEFAULTS_PATH=core/conf/ SD_CONF_FILE=~/src/surveys/development/stratdat/master/conf/config.pl /usr/bin/env perl -Ibuild/lib -Icore/lib core/bin/ws-yml-map Flatten Empty Dump 'XLS('master.xls')' Null < master.yaml
}

function yaml_to_xls() {
    SD_WSDEFAULTS_PATH=core/conf/ SD_CONF_FILE=~/src/development/university-melbourne/application-evaluation/default/conf/config.pl /usr/bin/env perl -Ibuild/lib -Icore/lib core/bin/ws-yml-map Flatten Empty Dump 'XLS('$1.xls')' Null < $1.yaml
}

function yaml_to_csv() {
    SD_WSDEFAULTS_PATH=core/conf/ SD_CONF_FILE=~/src/development/deecd/census-2014/default/conf/config.pl /usr/bin/env perl -Ibuild/lib -Icore/lib core/bin/ws-yml-map Empty Dump Flatten 'CSV('$1.csv')' Null < $1.yaml
}

function yaml_to_yaml() {
SD_WSDEFAULTS_PATH=core/conf/ SD_CONF_FILE=~/src/surveys/production/lom/salary-and-cultural-survey/conf/config.pl /usr/bin/env perl -Ibuild/lib -Icore/lib core/bin/ws-yml-map 'SlotProperty(pretty_value)' Dump Completed Null < $1.yaml
}

leak() { perl -ple 'print STDERR'; }

### Aliases ###
alias love="/Applications/love.app/Contents/MacOS/love"


alias http="plackup -MPlack::App::Directory -e 'Plack::App::Directory->new({ root => \$ENV{PWD} })->to_app;'"
alias RM='rm -rf'
alias vi='vim'


alias ssh="ssh -A"
alias tmux_websurvey='tmuxinator start websurvey-setup'
alias http="plackup -MPlack::App::Directory -e 'Plack::App::Directory->new({ root => \$ENV{PWD} })->to_app;'"
alias footytips='ssh ashpe@173.231.53.150'
alias homepc='ssh ashpe@203.132.88.127'
alias ll='ls -l -G'
alias ls='ls -G'
alias la='ls -la -G'
alias RM='rm -rf'
alias perlsw='perl -Mstrict -Mwarnings'
alias perldd='perl -MData::Dumper'
alias perlxxx='perl -MXXX'
alias GETf='GET -UseS'
alias POSTf='POST -UseS'
alias HEADf='HEAD -UseS'
alias i=clear
alias scpresume="rsync --partial --progress --rsh=ssh"
alias v='vim'
alias vi='vim'
alias im='vim'
alias :e='vim'

alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..6='cd ../../../../../../..'
alias ..7='cd ../../../../../../../..'
alias ..8='cd ../../../../../../../../..'
alias ..9='cd ../../../../../../../../../..'

alias gst='git status'
alias gbr='git branch'
alias gd='git diff'
alias gdp='gd | vim -'
alias gdc='git diff --cached'
alias gdcp='gdc | vim -'
alias ga='git add'
alias gau='git add -u'
alias gco='git checkout'
alias gci='git commit -v'
alias gcim='git commit -v -m'
alias gcia='git commit -v -a'
alias gciam='git commit -v -a -m'
alias gl='git log'
alias glol='git log --pretty=oneline'
alias glop='git log -p -1'
alias guppy='gup && gpu'
alias sup='git stash && gup && git stash pop'
alias suppy='git stash && gup && gpu && git stash pop'
alias gls='git ls-files --exclude-standard'
alias gcp='git cherry-pick -x'
alias grh='git reset --hard HEAD'
alias gundo='git reset HEAD^'
alias gsr='git svn rebase'
alias gsdc='git svn dcommit'


