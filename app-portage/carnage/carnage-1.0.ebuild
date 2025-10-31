# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature desktop xdg

DESCRIPTION="TUI front-end for Portage and eix"
HOMEPAGE="https://github.com/dsafxP/carnage"
SRC_URI="https://github.com/dsafxP/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/lxml-6.0.2[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/textual-6.4.0[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.13.3[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	domenu assets/carnage.desktop

	doicon -s scalable assets/carnage.svg
}

pkg_postinst() {
	optfeature "package & use flag browsing" app-portage/eix

	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
