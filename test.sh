#!/usr/bin/env bash

set +e

if [[ "${TRAVIS_EVENT_TYPE}" != 'cron' ]]; then
  cd luatexja/test

  ret=0

  for f in test02-latex.tex test04a-jfm-hyper.tex test07-math-unicode.tex test07-math.tex test08-tombow.tex test09-fontspec.tex test10-otf.tex test12-ltjarticle.tex test12-ltjtarticle.tex test13-listings.tex test15-catcode-latex.tex test16-preset.tex test17-priority.tex test17-totenwidth.tex test18-grid.tex test19-ivs-vert.tex test19-ivs.tex test20a-mfont-fontspec.tex test23a-tuenc.tex test51a-vert_vrt2.tex test55-boxdim_diffdir.tex; do
    lualatex --interaction=nonstopmode "$f";
    ret=$(($ret | $?))
  done

  for f in test01.tex test03-after.tex test04-jfm.tex test06-offset.tex test15-catcode.tex test24-jfmv3.tex; do
    luatex --interaction=nonstopmode "$f";
    ret=$(($ret | $?))
  done

  # luajitlatexってどこにあるの？
  #
  # for f in test10a-otf-ttf.tex test21-kanjiskip-fontspec.tex test21-kanjiskip.tex test51-vtest.tex test52-vtest-ins.tex test54-lltjext.tex test54a-lltjext.tex test56-lltjext-picture.tex test57-ascmac.tex; do
  #   luajitlatex --interaction=nonstopmode "$f";
  #   ret=$(($ret | $?))
  # done

  cd ..

  exit $ret
fi
