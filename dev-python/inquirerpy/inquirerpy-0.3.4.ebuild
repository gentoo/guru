# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

MY_PN="InquirerPy"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Python port of Inquirer.js (A collection of common interactive CLI UIs)"
HOMEPAGE="
	https://github.com/kazhala/InquirerPy
	https://pypi.org/project/inquirerpy/
"
PATCH_BASE_URI="https://github.com/falbrechtskirchinger/overlay-assets/releases/download"
SRC_URI="
	https://github.com/kazhala/${MY_PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
	${PATCH_BASE_URI}/v2026.06.27.0/${PN}-0.3.4-support-prompt-toolkit-3.0.47.patch.xz
"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# prompt-toolkit raised from 3.0.1 to 3.0.47 for patch
RDEPEND="
	>=dev-python/pfzy-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.47[${PYTHON_USEDEP}]
"

PATCHES=(
	"${WORKDIR}/${PN}-0.3.4-support-prompt-toolkit-3.0.47.patch"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_test() {
	# test expects non-empty home
	touch "${HOME}/.dummy" || die
	distutils-r1_src_test
}
