# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO="https://github.com/firecat53/urlscan"
inherit distutils-r1 pypi

DESCRIPTION="Mutt and terminal url selector"
HOMEPAGE="https://pypi.org/project/urlscan"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

BDEPEND="
	dev-python/hatchling[${PYTHON_USEDEP}]
"
RDEPEND="
	dev-python/urwid[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

DOCS=( README.md LICENSE )

python_prepare_all() {
	distutils-r1_python_prepare_all
	local docs=( "LICENSE" "\"README.md\"" "\"urlscan.1\"" )

	local doc
	for doc in "${docs[@]}"; do
		sed -ie "/${doc} =/d" \
			pyproject.toml || die
	done
}

python_install_all() {
	distutils-r1_python_install_all
	doman urlscan.1
}
