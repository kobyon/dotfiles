inventory := "/home/oliver.sakkestad/source/sakkenix/inventory/ansible"

WIP-backup:
  rsync -rltDzv root@sakkenix.cloud:/media/tank/data/documents/ ./

deploy-nginx-to-web003:
	ansible-playbook playbooks/config/nginx.yaml -l no12829v-web003 --ask-become-pass

deploy-netbox-config-prod:
	ansible-playbook playbooks/config/netbox.yaml -l no99123v-netbox002 --ask-become-pass

deploy-puppetmaster-prod:
	ansible-playbook playbooks/main/update-puppetmaster.yaml --limit no99123v-osl-pup006 --ask-become-pass

deploy-puppetmaster-dev:
	ansible-playbook playbooks/main/update-puppetmaster.yaml --limit no99123v-osl-pup005 --ask-become-pass

update-puppetlab:
	ansible-playbook playbooks/main/update-puppetmaster.yaml playbooks/main/update-puppet-agents.yaml --limit group_puppet_lab

ansible-facts host:
	ansible -i {{ inventory }} {{host}} -m setup -k

ansible-apply-role host role:
	ansible -i {{ inventory }} {{host}} -m include_role -a name={{role}}

ansible-inventory:
	ansible-inventory -i {{ inventory }} --list

run-on-server host +command:
	ssh {{host}} {{command}}

install-ruby:
	sudo apt-get install build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc
	mkdir -p "${RBENV_ROOT}"
	git clone https://github.com/rbenv/rbenv.git "${RBENV_ROOT}"
	git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
	print "%s" "List installable ruby versions by running: rbenv install -l"
	print "%s" "Install ruby version by running: rbenv install <version>"
	print "%s" "Set global ruby version by running: rbenv global <version>"
	print "%s" "Set local ruby version by running: rbenv local <version>"
	print "%s" "Install bundler by running: gem install bundler"

dot-pull:
  /usr/bin/git \
  --git-dir="${HOME}/.local/share/dotfiles/git" \
  --work-tree="${HOME}" pull --rebase --autostash

update-ansible-config:
  ansible-playbook playbooks/group-${hostname -s }.yaml --ask-become-pass
  dot-pull

update:
  update-ansible-config
  dot-pull
