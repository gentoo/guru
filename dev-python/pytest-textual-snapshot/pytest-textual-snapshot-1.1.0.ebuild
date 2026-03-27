# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Snapshot testing for Textual apps"
HOMEPAGE="
	https://github.com/Textualize/pytest-textual-snapshot
	https://pypi.org/project/pytest-textual-snapshot/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/jinja2-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/rich-12.0.0[${PYTHON_USEDEP}]
	>=dev-python/syrupy-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/textual-0.28.0[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-1.1.0-syrupy-5-compat.patch"
)

src_prepare() {
	distutils-r1_src_prepare

	# Convert to proper Python package
	mkdir pytest_textual_snapshot || die

	mv pytest_textual_snapshot.py pytest_textual_snapshot/__init__.py || die
	mv resources pytest_textual_snapshot/ || die

	sed -i 's|"resources/\*\*/\*"|"pytest_textual_snapshot/resources/\*\*/\*"|' \
		pyproject.toml || die
}
