# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 optfeature

DESCRIPTION="TCP/UDP asynchronous tunnel proxy implemented in Python3 asyncio"
HOMEPAGE="
	https://github.com/qwj/python-proxy
	https://pypi.org/project/pproxy
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	optfeature "ssh tunnelling" ">=dev-python/asyncssh-2.5.0"
	optfeature "accelerated ciphers" ">=dev-python/pycryptodome-3.7.2"
	optfeature "accelerated ciphers" ">=dev-python/uvloop-0.13.0"
	optfeature "daemon" ">=dev-python/python-daemon-2.2.3"
}
