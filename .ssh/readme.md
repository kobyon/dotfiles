1. Create a normal id_rsa for the computer
2. Rename id_rsa.pub to hostname of the computer
	`mv id_rsa.pub <hostname>.pub`
3. Syslink the rename public key to id_rsa.pub
	`ln -sf <hostname>.pub id_rsa.pub`
4. Add the public key to dotfiles repo
	`dotfiles add -f <hostname>.pub`
