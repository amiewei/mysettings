# configure Novde Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Git Completion
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash

autoload -Uz compinit && compinit

# Load Git Prompt
if [ -f "$HOME/.git-prompt.sh" ]; then
    source "$HOME/.git-prompt.sh"
    setopt PROMPT_SUBST ; 

    # check if there is a git inside the directory, if so, will reload to show updates
    function git_prompt_hook() {
        if [ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
            __git_ps1 "(%s)"
            echo -n $'\033]0;'$(basename "$(git rev-parse --show-toplevel)")' - git '$(__git_ps1 "(%s)")$'\007'
        fi
    }
    
    autoload -U add-zsh-hook
    add-zsh-hook precmd git_prompt_hook

    #change zsh font color and display git branch name in terminal
    PS1="%b%F{225}%n@%F{225}%m%f%b %b%f%~ %F{158}\$(__git_ps1 \"(🌱%s)\") %(!.#.$)%f%b %F{158}"
fi