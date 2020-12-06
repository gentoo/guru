# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_7 )

inherit distutils-r1 optfeature

DESCRIPTION="HTTP/Socks4/Socks5/Shadowsocks/ShadowsocksR/SSH/Redirect/Pf TCP/UDP asynchronous tunnel proxy implemented in Python3 asyncio"
HOMEPAGE="
	https://github.com/qwj/python-proxy
	https://pypi.org/project/pproxy
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_postinst() {
	optfeature "ssh tunnelling" ">=dev-python/asyncssh-1.16.0"
	optfeature "accelerated ciphers" ">=dev-python/pycryptodome-3.7.2"
	optfeature "daemon" ">=dev-python/python-daemon-2.2.3"
	optfeature "accelerated cyphers" ">=dev-python/uvloop-0.13.0"
}
