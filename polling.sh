#!/usr/bin/env bash

set +e

if [[ "${TRAVIS_EVENT_TYPE}" == 'cron' && "${TRAVIS_OS_NAME}" == "linux" && "${TRAVIS_BRANCH}" == "master" && "${TRAVIS_PULL_REQUEST}" == "false" ]]; then
  echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile ~/.ssh/deploy.key\n" >> ~/.ssh/config
  openssl aes-256-cbc -k "$SERVER_KEY" -in deploy_key.enc -d -a -out deploy.key
  cp deploy.key ~/.ssh/
  chmod 600 ~/.ssh/deploy.key
  
  git config --global user.email "yyu@mental.poker"
  git config --global user.name "Yoshimura Yuu"
    
  cd luatexja
  git pull origin master
  cd ..
  git add luatexja
  git commit -m "Update luatexja $TRAVIS_JOB_NUMBER $TRAVIS_COMMIT"

  git push origin master

  exit 0
fi
