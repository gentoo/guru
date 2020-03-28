# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Spell checker automation tool"
HOMEPAGE="https://github.com/facelessuser/pyspelling"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#IUSE="doc"

# Need mkdocs-1.1 for this
#BDEPEND="
#	doc? (
#		dev-python/mkdocs-git-revision-date-localized-plugin
#		dev-python/mkdocs_pymdownx_material_extras
#		~dev-python/mkdocs-material-5.0.0_rc2
#	)
#"

RDEPEND="
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/soupsieve-1.8[${PYTHON_USEDEP}]
	>=dev-python/wcmatch-4.0[${PYTHON_USEDEP}]
"

PATCHES="${FILESDIR}/${P}-do-not-install-tests.patch"

distutils_enable_tests pytest

#python_compile_all() {
#	default
#	if use doc; then
#		mkdocs build || die "failed to make docs"
#		HTML_DOCS="site"
#	fi
#}
