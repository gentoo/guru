# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

MY_PN="griffe"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Signatures for entire Python programs"
HOMEPAGE="
	https://mkdocstrings.github.io/griffe
	https://github.com/mkdocstrings/griffe
	https://pypi.org/project/griffelib/
"
SRC_URI="https://github.com/mkdocstrings/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# pdm-backend is used by scripts/get_version.py
BDEPEND="
	dev-python/pdm-backend[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# requires mkdocstrings
	tests/test_api.py
	# require griffecli
	tests/test_cli.py
	tests/test_git.py
)

python_compile() {
	cd packages/griffelib || die
	distutils-r1_python_compile
}

python_install() {
	cd packages/griffelib || die
	distutils-r1_python_install
}
