#!/bin/sh

extra_defs=""

while test -n "$1"; do
  case $1 in
    -D*)
      extra_defs="$extra_defs $1"
      ;;
    -*)
      echo "[ERROR] Unknown option $1"
      ;;
    *)
      echo "[ERROR] Unknown argument $1"
      ;;
  esac
  shift
done

. ./packages.properties

plat=`uname`
arch=`uname -m`
pwd=`pwd`


if test "$plat" = "MINGW32_NT-6.1" || 
   test "$plat" = "CYGWIN_NT-6.1"; then
  eclipse=eclipsec
else
  eclipse=eclipse
fi

${ECLIPSE_HOME}/$eclipse \
    -nosplash -application org.eclipse.ant.core.antRunner \
    --launcher.suppressErrors \
    -buildfile build.xml      \
    -data ../buildRoot/ws     \
    $extra_defs build_dvkit

exit $?

