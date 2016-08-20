#!/bin/sh

plat=`uname`
arch=`uname -m`
pwd=`pwd`


if test "$plat" = "MINGW32_NT-6.1" || 
   test "$plat" = "CYGWIN_NT-6.1"; then
  eclipse=eclipsec
else
  eclipse=eclipse
fi

#    -verbose                  \


${ECLIPSE_HOME}/${eclipse} -nosplash \
    -application org.eclipse.ant.core.antRunner \
    --launcher.suppressErrors \
    -buildfile mk_dvkit.xml   \
    -data ../buildRoot/ws     \
    -Dos=win32 -Dws=win32 mk_msi

