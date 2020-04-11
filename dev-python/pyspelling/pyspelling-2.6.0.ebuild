# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

DOCBUILDER="mkdocs"
DOCDEPEND="
	dev-python/mkdocs_pymdownx_material_extras
	~dev-python/mkdocs-material-5.0.0_rc2"

inherit distutils-r1 docs

DESCRIPTION="Spell checker automation tool"
HOMEPAGE="https://github.com/facelessuser/pyspelling"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	|| ( app-text/aspell app-text/hunspell )

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

python_prepare_all() {
	# git revision data plugin needs git repo to build
	# do not depend on this
	sed -i -e '/git-revision-date-localized/d' \
		mkdocs.yml || die

	distutils-r1_python_prepare_all
}
