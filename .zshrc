
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Flutter & Dart paths (project-local)
export PATH="$PATH:/Users/romsmacbook/Documents/supply_chain_app/flutter/bin"
export PATH="$PATH:/Users/romsmacbook/Documents/supply_chain_app/flutter/bin/cache/dart-sdk/bin"

export PATH="$PATH:/opt/homebrew/lib/ruby/gems/3.4.0/bin"
