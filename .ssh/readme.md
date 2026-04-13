# Documentation for personal SSH setup
The `.ssh` folder should contain all public keys from all computers,
but only the private key of the active computer.

Keys should be named after hostname an Symlinked to the active key, id_rsa.

## ssh-agent
The ssh agent is loaded by seahorse on client devices.
[TODO] Find a good way to load the keys into agent on devices with no DE.

## .ssh/config
Individual to each computer.  Should be created individually.

# Creating new ssh keys
1. Create a normal id_rsa for the computer
	`ssh-keygen -t rsa -b 4096 -o -a 100`
2. Rename id_rsa.pub to hostname of the computer
	`mv id_rsa.pub <hostname>.pub`
3. Syslink the rename public key to id_rsa.pub
	`ln -sf <hostname>.pub id_rsa.pub`
4. Add the public key to dotfiles repo
	`dotfiles add -f <hostname>.pub`

```shell
ssh-keygen -t rsa -b 4096 -o -a 100 -f $(hostname -s)
ln -sf $(hostname -s).pub id_rsa.pub
ln -sf $(hostname -s) id_rsa
dotfiles add -f $(hostname -s).pub
```
