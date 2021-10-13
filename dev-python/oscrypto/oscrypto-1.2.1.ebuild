# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="TLS sockets, key generation, encryption, decryption, signing, verification"
HOMEPAGE="
	https://github.com/wbond/oscrypto
	https://pypi.org/project/oscrypto/
"
SRC_URI="https://github.com/wbond/oscrypto/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
#tests requires network
RESTRICT="test"

RDEPEND=">=dev-python/asn1crypto-1.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	"${EPYTHON}" run.py tests || die
}

python_install_all() {
	distutils-r1_python_install_all
	dodoc -r docs/*
}
