#!/bin/bash

cd terraform && echo $(terraform output ip_addr) > ip.txt && cd ..
sed "s/XXXX/$(cat ./terraform/ip.txt)/" ./ansible/hosts.template > ./ansible/hosts
sed "s/XXXX/$(cat ./terraform/ip.txt)/" ./tests/tests.sh.template > ./tests/tests.sh
