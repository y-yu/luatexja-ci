#!/usr/bin/env bash

set +e

if [[ "${TRAVIS_EVENT_TYPE}" != 'cron' ]]; then
  cd luatexja/test

  ret=0
  for f in `ls *.tex`; do
    lualatex --interaction=nonstopmode --shell-escape "$f";
    ret=$(($ret | $?))
  done

  cd ..

  exit $ret
fi
