#!/usr/bin/env bash

set -e

if [[ "${TRAVIS_EVENT_TYPE}" != 'cron' ]]; then
  wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/install-tex.sh
  wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/tlmgr.sh
  chmod +x install-tex.sh tlmgr.sh

  . ./install-tex.sh
  ./tlmgr.sh install collection-luatex adobemapping ipaex everyhook svn-prov
  cd luatexja/src

  echo "Compile ltjclasses.ins"
  lualatex --interaction=nonstopmode ltjclasses.ins

  echo "Compile ltjsclasses.ins"
  lualatex --interaction=nonstopmode ltjsclasses.ins

  echo "Compile ltjltxdoc.ins"
  lualatex --interaction=nonstopmode ltjltxdoc.ins

  echo "Run ltj-kinsoku_make.tex"
  luatex --interaction=nonstopmode ltj-kinsoku_make.tex || true

  mkdir -p /home/travis/texlive/texmf-local/tex/luatex/luatexja
  cp -r * "$HOME/texlive/texmf-local/tex/luatex/luatexja/"

  mktexlsr

  cd "$TRAVIS_BUILD_DIR"
fi
