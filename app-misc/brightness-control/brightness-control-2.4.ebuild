# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=poetry
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 desktop optfeature

MY_PN="Brightness"
DESCRIPTION="Qt Brightness Controller in Python"
HOMEPAGE="https://github.com/lordamit/Brightness"
SRC_URI="https://github.com/lordamit/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}/brightness-controller-linux"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="$(python_gen_cond_dep \
	'dev-python/QtPy[${PYTHON_USEDEP},gui,network,pyqt5,widgets]'
)"

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all

	sed "/readme.md/d" -i pyproject.toml || die
}

python_install_all () {
	distutils-r1_python_install_all

	doicon -s scalable brightness_controller_linux/icons/brightness-controller.svg
	make_desktop_entry brightness-controller "Brightness Controller" brightness-controller Settings
}

pkg_postinst() {
	optfeature "direct control" app-misc/ddcutil
}
