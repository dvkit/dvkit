

mkdir ../buildRoot
%ECLIPSE_HOME%\eclipsec -nosplash ^
    -application org.eclipse.ant.core.antRunner ^
    --launcher.suppressErrors ^
    -buildfile build.xml      ^
    -data ../buildRoot/ws     ^
    -verbose                  ^
    -Dos=win32 -Dws=win32 build_dvkit

