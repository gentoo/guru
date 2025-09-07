# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SRC_URI="https://git.sr.ht/~apreiml/himitsu-secret-service/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~riscv"

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="himitsu secret-service integration"
HOMEPAGE="https://git.sr.ht/~apreiml/himitsu-secret-service"
LICENSE="MIT"
SLOT="0"
IUSE="+man"

RDEPEND="
	>=app-admin/himitsu-0.9
	>=dev-python/py-himitsu-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/cryptography-45.0.5[${PYTHON_USEDEP}]
	>=dev-python/dbus-python-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/pygobject-3.50.1[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	man? ( >=app-text/scdoc-1.11.3 )
"

src_configure() {
	sed -i 's;PREFIX=/usr/local;PREFIX=/usr;' Makefile || die
	sed -i "s;python3;${EPYTHON};g" Makefile || die
}

src_compile() {
	scdoc < docs/himitsu-secret-service.5.scd > himitsu-secret-service.5
	scdoc < docs/himitsu-secret-service.7.scd > himitsu-secret-service.7
	scdoc < docs/hisecrets-agent.1.scd > hisecrets-agent.1
	distutils-r1_src_compile
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /usr/share/man/man1
	doins hisecrets-agent.1

	insinto /usr/share/man/man5
	doins himitsu-secret-service.5

	insinto /usr/share/man7
	doins himitsu-secret-service.7
}
