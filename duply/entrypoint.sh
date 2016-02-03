#!/bin/bash

key="$1"

case $key in
	gpg-init)
		gpg --gen-key --homedir ${PWD}
	;;

	duply-init)
		PROJECT=$2
		if [ -z "$PROJECT" ]; then
			echo missing duply project id
			exit 1
		fi

		duply ${PROJECT} create
		PUB=`gpg --homedir ${PWD} --list-keys | awk -F"[/ \t]" '/^pub/ {print $5}'`

		if [ -z "$PUB" ]; then
			echo error parsing key id
			exit 1
		fi

		gpg --homedir ${PWD} --export -a -o ${PWD}/${PROJECT}/gpgkey.${PUB}.pub.asc ${PUB}
		gpg --homedir ${PWD} --export-secret-keys -a -o ${PWD}/${PROJECT}/gpgkey.${PUB}.sec.asc ${PUB}
		sed -i "s/_KEY_ID_/${PUB}/" ${PWD}/${PROJECT}/conf
		sed -i "s/SOURCE='\/path\/of\/source'/SOURCE='\/mnt'/" ${PWD}/${PROJECT}/conf

		echo "Please edit GPG_PW, SOURCE, TARGET and MAX_AGE in ${PROJECT}/conf"
	;;

	duply-run)
		PROJECT=$2
		if [ -z "$PROJECT" ]; then
			echo missing duply project id
			exit 1
		fi

		duply ${PROJECT} backup_purge --force 2>&1
	;;

	duply)
		PROJECT=$2
		if [ -z "$PROJECT" ]; then
			echo missing duply project id
			exit 1
		fi

		duply ${PROJECT} ${@:3} 2>&1
	;;

	cmd)
		${@:2}
	;;

	*)
		echo "no command given. try"
		echo " gpg-init                    create keys"
		echo " duply-init [project-id]     create duply project"
		echo " duply-run [project-id]      do backup"
		echo " duply [project-id] ...      run any duply command"
		echo " cmd ...                     run any shell command"
		echo ""
		echo "You should mount project volume to /root/.duply and backup volume to /mnt"
		echo ""
	;;
esac
