
# echo is like puts for bash (bash is the program running in your terminal)
# $VARIABLE will render before the rest of the command is executed
echo "Logged in as $USER on $(hostname)"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Path for RVM
test -d "$HOME/.rvm/bin" && PATH="$PATH:$HOME/.rvm/bin"

# Rbenv autocomplete and shims
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# Path for RBENV
test -d "$HOME/.rbenv/" && PATH="$HOME/.rbenv/bin:$PATH"

# Path changes are made non-destructive with PATH=new_path;$PATH   This is like A=A+B so we preserve the old path

# Path order matters, putting /usr/local/bin before /usr/bin
# ensures brew programs will be seen and used before another program
# of the same name is called

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
# Path for Heroku
test -d /usr/local/heroku/ && export PATH="/usr/local/heroku/bin:$PATH"

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# Path for twig-lint
test -d $HOME/.composer/vendor/asm89/twig-lint/bin && export PATH="$PATH:$HOME/.composer/vendor/asm89/twig-lint/bin"

# Configure autocompletions to work with git aliases
# (git aliases in .gitconfig)
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done

# Git branch in prompt

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e's/* \(.*\)/[\1]/'

}

export PS1="\W\[\033[32m\] \$(parse_git_branch)\[\033[00m\]\033"
export PS2=">> "

function _update_ps1() {
    PS1="$(~/powerline-shell/powerline-shell.py $? 2> /dev/null) \n>> : "
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex

# Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'

# Use updated Vim (via MacVim (instead of preinstalled Vim 7.3))
alias v="/Applications/MacVim.app/Contents/MacOS/Vim"
# Set Vim as the default editor
which -s vim && export EDITOR="vim --wait"

# Temp aliases for projects
alias sop="cd ~/SOP/someoddpilot"
alias nike="cd ~/SOP/nike-hat-customizer/wp-content/themes/nike-hat-customizer-theme"

# Useful aliases
alias ll="ls -Glah"

alias be="bundle exec"
alias slashburn="be rake db:drop && be rake db:create && be rake db:migrate && be rake db:seed && be rake db:test:prepare"

alias git="hub"
alias gph="git push heroku master; heroku run rake db:migrate"

alias phpmamp='/Applications/MAMP/bin/php/php5.4.42/bin/php'

alias pr="hub pull-request"

export PATH="/usr/local/mysql/bin:$PATH"

eval "$(hub alias -s)"
