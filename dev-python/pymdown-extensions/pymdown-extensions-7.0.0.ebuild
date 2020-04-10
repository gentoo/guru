# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

DOCBUILDER="mkdocs"
DOCDEPEND="
	dev-python/mkdocs-minify-plugin
	dev-python/mkdocs-git-revision-date-localized-plugin
	dev-python/mkdocs-material
	dev-python/pymdown-lexers
	dev-python/pyspelling
"

inherit distutils-r1 docs

DESCRIPTION="Extensions for Python Markdown."
HOMEPAGE="
	https://github.com/facelessuser/pymdown-extensions
	https://pypi.org/project/pymdown-extensions
"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/markdown-3.2[${PYTHON_USEDEP}]"

DEPEND="test? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_prepare_all() {
	# git revision date plugin needs git repo to build
	if use doc; then
		git init || die
		git add -A || die
		git commit -q -m ".." || die
	fi
	distutils-r1_python_prepare_all
}
