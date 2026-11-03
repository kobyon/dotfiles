# Lazy-load nvm: sourcing nvm.sh costs ~1s, so only do it on first use of `nvm`.
# The default node version is already on PATH via ~/.config/shell/profile.
nvm() {
	unfunction nvm
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	nvm "$@"
}
