#!/bin/bash

function getOsType()
{
    if [ `uname -s` == "Darwin" ]; then
        echo "MACOS"
    else
        echo "LINUX"
    fi
}

OS_TYPE=$(getOsType)
if [ $OS_TYPE == "MACOS" ]; then
    SED_BIN='sed -i --'
else
	SED_BIN='sed -i'
fi


ARGS=$(getopt -o h --long help,prefix: -n 'Install GameBox Cloud Core' -- "$@")

eval set -- "$ARGS"


_env() {
	if [ $OSTYPE == "MACOS" ]; then
		brew install python virtualenv supervisor
	fi
}
_lualib() {
	luarocks install luasocket
	luarocks install process --from=http://mah0x211.github.io/rocks/
}

_redis() {

	# ----
	#install redis
	echo ""
	echo -e "[\033[32mINSTALL\033[0m] redis"
	if [ $OSTYPE == "MACOS" ]; then
		brew install redis
	fi
}
_beanstalk() {
	# ----
	# install beanstalkd
	echo ""
	echo -e "[\033[32mINSTALL\033[0m] beanstalkd"

	cd /tmp
	git clone https://github.com/baysao/beanstalkd.git
	cd beanstalkd
	make install 
}
_env
_lualib
_redis
_beanstalk


