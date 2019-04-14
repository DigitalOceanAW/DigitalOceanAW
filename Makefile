build:
	cd packer && packer build main.json
	cd terraform && terraform init && echo 'yes' | terraform apply && terraform output ip_addr > ip.txt
	sh update_ips.sh
	sleep 10
	cd ansible && echo yes | ansible-playbook playbook.yml
	chmod +x ./tests/tests.sh
	sleep 10
	sh ./tests/tests.sh
