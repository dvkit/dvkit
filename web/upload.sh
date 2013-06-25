#!/bin/sh

scp -C -r html/*.html html/imgs \
  $SF_USERNAME,dvkit@web.sourceforge.net:htdocs

