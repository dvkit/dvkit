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

rm -rf ../buildRoot
mkdir ../buildRoot

arch=`uname -m`
pwd=`pwd`

cd ../buildRoot

if test $arch = "x86_64"; then
  tar xvzf ../packages/${eclipse_linux_x86_64_tgz}
else
  tar xvzf ../packages/${eclipse_linux_tgz}
fi

cd $pwd

../buildRoot/eclipse/eclipse \
    -nosplash -application org.eclipse.ant.core.antRunner \
    --launcher.suppressErrors \
    -buildfile build.xml      \
    -data ../buildRoot/ws     \
    -verbose                  \
    -Dos=linux -Dws=gtk -Darch=$arch $extra_defs build_dvk

