#!/bin/bash

apt-get update && apt-get install -y git
apt-get install -y rsync
git remote rm origin
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"
git config --global credential.helper 'store --file $HOME/.my-credentials'
git config --global credential.helper cache
git clone https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_REPO_OWNER/$GITHUB_REPO_NAME.git

pwd
ls
# rm -rf .git/
# rsync -av --exclude='$GITHUB_REPO_NAME' ./ $GITHUB_REPO_NAME/ && find . -maxdepth 1 ! -name $GITHUB_REPO_NAME ! -path $GITHUB_REPO_NAME -exec rm -rf {} \; 
#rsync -av --exclude='$GITHUB_REPO_NAME' ./ $GITHUB_REPO_NAME/ && find . -maxdepth 1 ! -name $GITHUB_REPO_NAME ! -path $GITHUB_REPO_NAME -exec mv {} $GITHUB_REPO_NAME/ \; && rm -rf ./*
mv -v !($GITHUB_REPO_NAME) $GITHUB_REPO_NAME/
shopt -s extglob # Ativa a extensão glob
rm -rf !($GITHUB_REPO_NAME|<$GITHUB_REPO_NAME>) # Apaga tudo exceto "x" e o repositório Git

cd $GITHUB_REPO_NAME
rm -rf .git/
pwd
ls
git init
git remote add origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_REPO_OWNER/$GITHUB_REPO_NAME.git
git checkout -b main
git remote -v
git add .
git commit -m "[skip CI]"
git push -f origin main


