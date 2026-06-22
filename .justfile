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

run-on-server host command:
	ssh {{host}} "{{command}}"
