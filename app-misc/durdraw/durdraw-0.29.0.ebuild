# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Versatile ASCII and ANSI Art text editor for drawing"
HOMEPAGE="https://github.com/cmang/durdraw"
SRC_URI="https://github.com/cmang/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

DOCS=( README.md LICENSE )

src_install() {
	distutils-r1_src_install
}
