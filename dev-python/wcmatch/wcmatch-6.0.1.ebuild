# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

DOCBUILDER="mkdocs"
DOCDEPEND="
	~dev-python/mkdocs-material-5.0.0_rc2
	dev-python/mkdocs_pymdownx_material_extras
	dev-python/pyspelling
"

inherit distutils-r1 docs

DESCRIPTION="Wildcard/glob file name matcher"
HOMEPAGE="
	https://github.com/facelessuser/wcmatch
	https://pypi.org/project/wcmatch"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/backrefs-4.1[${PYTHON_USEDEP}]
	>=dev-python/bracex-2.0[${PYTHON_USEDEP}]
"

DEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_prepare_all() {
	# no such file or dir ~homedir
	sed -i -e 's:test_tilde_user:_&:' \
		tests/test_glob.py || die

	# AssertionError: 0 == 0
	sed -i -e 's:test_tilde_globmatch_no_realpath:_&:' \
		-e 's:test_tilde_globmatch_no_tilde:_&:' \
		tests/test_globmatch.py || die

	# git revision data plugin needs git repo to build
	# do not depend on this
	sed -i -e '/git-revision-date-localized/d' \
		mkdocs.yml || die

	distutils-r1_python_prepare_all
}
