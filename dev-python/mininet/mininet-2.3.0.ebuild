# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Emulator for rapid prototyping of Software Defined Networks"
HOMEPAGE="
	https://github.com/mininet/mininet
"
SRC_URI="https://github.com/mininet/mininet/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="net-misc/openvswitch"

src_compile() {
	distutils-r1_src_compile

	emake mnexec
}

src_install() {
	distutils-r1_src_install

	PREFIX=${ED} emake install-mnexec
}
