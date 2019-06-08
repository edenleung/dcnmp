#!/bin/sh
cd /home/backup
git pull

git add -A .
git commit -m update
git push
