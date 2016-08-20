

%ECLIPSE_HOME%\eclipsec -nosplash ^
    -application org.eclipse.ant.core.antRunner ^
    --launcher.suppressErrors ^
    -buildfile mk_dvkit.xml   ^
    -data ../buildRoot/ws     ^
    -verbose                  ^
    -Dos=win32 -Dws=win32 mk_msi

