#!/bin/sh
cd /home/backup
git pull

mysqldump -h mysql56 -u root -p'1234' database > /home/backup/project-$(date +"%Y-%m-%d").sql
git add -A .
git commit -m update
git push
