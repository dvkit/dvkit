#!/bin/sh

. ../etc/dvkit_info.properties

echo "cd /home/frs/project/dvkit" > sftp.cmds
echo "-mkdir ${dvkit_version}" >> sftp.cmds
sftp -b sftp.cmds ${SF_USERNAME}@frs.sourceforge.net
rm -f sftp.cmds


rsync --progress -e ssh \
	../buildResult/dvkit-${dvkit_version}*.tar.gz \
	../buildResult/dvkit-${dvkit_version}*.deb \
	../buildResult/dvkit-${dvkit_version}*.zip \
	../buildResult/dvkit-${dvkit_version}*.msi \
	${SF_USERNAME}@frs.sourceforge.net:/home/frs/project/dvkit/${dvkit_version}

