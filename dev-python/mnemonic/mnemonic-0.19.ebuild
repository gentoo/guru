# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="Reference implementation of BIP-0039 for generating deterministic keys"
HOMEPAGE="https://github.com/trezor/python-mnemonic"

MY_PN="python-mnemonic"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/trezor/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
BDEPEND=""

distutils_enable_tests unittest

S="${WORKDIR}/${MY_P}"
