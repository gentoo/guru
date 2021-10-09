# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/mkdocs
	dev-python/mkdocs-material
"

inherit cmake python-any-r1 docs

DESCRIPTION="scripting language made for opensurge"
HOMEPAGE="https://alemart.github.io/surgescript"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alemart/surgescript.git"
	SLOT="0"
else
	SRC_URI="https://github.com/alemart/surgescript/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	SLOT="0/${PV}"
fi

LICENSE="Apache-2.0"

src_compile() {
	cmake_src_compile
	docs_compile
}
