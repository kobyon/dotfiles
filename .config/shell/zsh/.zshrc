# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# https://github.com/romkatv/powerlevel10k#instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Oh My Zsh settings here
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
KEEP_ZSHRC=true
HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)

# Lastly, source Oh My Zsh to enable it.
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ${ZDOTDIR}/.p10k.zsh
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh
