# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCS_BUILDER="sphinx"
DOCS_AUTODOC=0
DOCS_DIR="${S}/docs/source"

PYTHON_COMPAT=( python3_{8,9} )

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
