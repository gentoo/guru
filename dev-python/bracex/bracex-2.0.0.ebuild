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

DESCRIPTION="Bash style brace expansion for Python"
HOMEPAGE="
	https://github.com/facelessuser/bracex
	https://pypi.org/project/bracex
"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_prepare_all() {
	# git revision data plugin needs git repo to build
	# do not depend on this
	sed -i -e '/git-revision-date-localized/d' \
		mkdocs.yml || die

		distutils-r1_python_prepare_all
}
