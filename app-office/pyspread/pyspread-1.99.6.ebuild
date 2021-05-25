# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit xdg desktop distutils-r1

DESCRIPTION="Pyspread is a non-traditional spreadsheet written in Python"
HOMEPAGE="https://pyspread.gitlab.io"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/pyspread/${PN}.git"
else
	SRC_URI="https://gitlab.com/pyspread/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	>=dev-python/PyQt5-5.10.0[gui,printsupport,svg,widgets,${PYTHON_USEDEP}]
	>=dev-python/markdown2-2.3[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/pyenchant-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.7.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

# TODO: package sphinxbootstrap4theme
#distutils_enable_sphinx apidocs \
#	"dev-python/sphinx-autodoc-typehints" \
#	"dev-python/recommonmark" \
#	"dev-python/sphinxbootstrap4theme"

python_prepare_all() {
	distutils-r1_python_prepare_all

	# Fix the provided desktop file
	sed -i -e '/Path/d' "${PN}.desktop" || die
}

python_install() {
	distutils-r1_python_install

	doicon "${PN}"/share/icons/"${PN}.ico"
	doicon "${PN}"/share/icons/"${PN}.svg"
	domenu "${PN}.desktop"
}

python_test() {
	export QT_QPA_PLATFORM=offscreen
	epytest
}
