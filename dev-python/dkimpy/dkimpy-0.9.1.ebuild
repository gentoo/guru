# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Python module implementing DKIM email signing and verification."
HOMEPAGE="https://launchpad.net/dkimpy"
SRC_URI="https://launchpad.net/${PN}/0.9/${PV}/+download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

python_test() {
	"${EPYTHON}" -m unittest discover -v
}
