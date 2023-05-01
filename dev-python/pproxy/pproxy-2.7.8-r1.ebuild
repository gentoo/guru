# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 optfeature pypi

DESCRIPTION="TCP/UDP asynchronous tunnel proxy implemented in Python3 asyncio"
HOMEPAGE="
	https://pypi.org/project/pproxy/
	https://github.com/qwj/python-proxy
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	optfeature "ssh tunnelling support" dev-python/asyncssh
	optfeature "accelerated ciphers support" "dev-python/pycryptodome dev-python/uvloop"
	optfeature "daemon support" dev-python/python-daemon
}
