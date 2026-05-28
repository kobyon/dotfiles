# Set Oh My Zsh settings here
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
KEEP_ZSHRC=true
HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="robbyrussell"
plugins=(git)

# Lastly, source Oh My Zsh to enable it.
source $ZSH/oh-my-zsh.sh


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
