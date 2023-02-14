# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_AUTODOC=1
DOCS_DEPEND="dev-python/sphinx-rtd-theme"
DOCS_DIR="${S}/docs/source"

PYTHON_COMPAT=( python3_{8..11} )

inherit python-any-r1
inherit docs meson

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/recp/cglm.git"
else
	SRC_URI="https://github.com/recp/cglm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="OpenGL Mathematics (glm) for C"
HOMEPAGE="https://github.com/recp/cglm"
LICENSE="MIT"
SLOT="0"

src_prepare() {
	default
	# Enable autodoc since themeing plugin is used.
	sed -i "s#'sphinx.ext.githubpages'#'sphinx.ext.githubpages','sphinx.ext.autodoc'#" docs/source/conf.py || die
}

src_configure() {
	local emesonargs=(
		"-Dwerror=false"
	)
	meson_src_configure
}

src_compile() {
	default
	meson_src_compile
	docs_compile
}
