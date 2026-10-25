# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The Official Api Spec Language for Dropbox"
HOMEPAGE="
	https://www.dropbox.com/developers
	https://github.com/dropbox/stone
	https://pypi.org/project/stone/
"
SRC_URI="https://github.com/dropbox/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/${PN}-3.5.3-unvendor-ply.patch
)

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

src_prepare() {
	default

	# Unvendor ply
	rm -r stone/_vendor || die
	rm test/test_vendored_ply.py || die
	rm test/test_version.py || die
}
