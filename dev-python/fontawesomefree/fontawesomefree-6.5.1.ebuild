# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Font Awesome Free"
HOMEPAGE="
	https://github.com/FortAwesome/Font-Awesome
	https://pypi.org/project/fontawesomefree/
"
SRC_URI=$(pypi_wheel_url)
S="${WORKDIR}"

LICENSE="CC-BY-4.0 OFL-1.1 MIT"
SLOT="0"
KEYWORDS="~amd64"

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${P}-py3-none-any.whl"
}
