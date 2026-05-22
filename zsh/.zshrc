autoload -Uz compinit && compinit -u
path=($HOME/Documents/Code/lightspeed/mkt-hq-website/local/bin $path)
path=($HOME/Documents/Code/flutter/bin $path)
path=($HOME/Documents/Code/flutter/bin $path)
export path
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home/

# Added by Antigravity
export PATH="/Users/dskoziol/.antigravity/antigravity/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dskoziol/Documents/Code/github/cookwitty/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dskoziol/Documents/Code/github/cookwitty/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dskoziol/Documents/Code/github/cookwitty/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dskoziol/Documents/Code/github/cookwitty/google-cloud-sdk/completion.zsh.inc'; fi
export HOMEBREW_NO_AUTO_UPDATE=1

# Added by Antigravity IDE
export PATH="/Users/dskoziol/.antigravity-ide/antigravity-ide/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/Users/dskoziol/.local/bin:$PATH"

# Project shortcuts
unalias cookwitty 2>/dev/null
cookwitty() {
    if [[ "$1" == "-n" || "$1" == "--new" || "$1" == "--fresh" ]]; then
        echo "Clearing cached session and starting fresh..."
        zellij kill-session cookwitty 2>/dev/null
    fi
    zellij --layout cookwitty attach -c cookwitty
}

# Setup Starship prompt
eval "$(starship init zsh)"
