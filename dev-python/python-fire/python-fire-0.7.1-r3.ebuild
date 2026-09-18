# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="fire"
inherit distutils-r1 pypi

DESCRIPTION="Library for automatically generating command line interfaces from Python objects"
HOMEPAGE="https://pypi.org/project/fire"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/termcolor[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/python-fire-asyncio.patch"
	"${FILESDIR}/python-fire-inspect.patch"
)

EPYTEST_PLUGINS=( pytest-asyncio )

distutils_enable_tests pytest

src_prepare() {
	default
	# Update / remove deprecated options
	sed -ie "/license =/d" pyproject.toml \
		|| die "Failed to remove deprecated setuptools options"
}
