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

plat=`uname`
arch=`uname -m`
pwd=`pwd`


if test "$plat" = "MINGW32_NT-6.1"; then
  eclipse=eclipsec
else
  eclipse=eclipse
fi

${ECLIPSE_HOME}/$eclipse \
    -nosplash -application org.eclipse.ant.core.antRunner \
    --launcher.suppressErrors \
    -buildfile build.xml      \
    -data ../buildRoot/ws     \
    -verbose                  \
    $extra_defs build_dvkit

exit 0

cd ../buildRoot

if test "$plat" = "MINGW32_NT-6.1"; then
  unzip ../packages/${eclipse_win32_x86_64_zip}
else
  if test $arch = "x86_64"; then
    tar xvzf ../packages/${eclipse_linux_x86_64_tgz}
  else
    tar xvzf ../packages/${eclipse_linux_tgz}
  fi
fi


mkdir deltapack
cd deltapack

unzip -o ../../packages/${eclipse_delta_pack_zip}

cd $pwd

export ECLIPSE_HOME=`cd ../buildRoot/eclipse ; pwd`

../buildRoot/eclipse/eclipse \
    -nosplash -application org.eclipse.ant.core.antRunner \
    --launcher.suppressErrors \
    -buildfile build.xml      \
    -data ../buildRoot/ws     \
    -verbose                  \
    $extra_defs build_dvkit


#    -Dos=linux -Dws=gtk -Darch=$arch $extra_defs build_dvkit



