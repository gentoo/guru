# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

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

IUSE="doc"

BDEPEND="dev-util/meson
	doc? ( dev-python/sphinx )"

src_configure() {
	local emesonargs=(
		"-Dwerror=false"
	)
	meson_src_configure
}

src_compile() {
	default
	meson_src_compile
	if use doc; then
		einfo "Building documentation ..."
		local doc_dir="${S}/docs"
		cd "${doc_dir}" || die "Cannot chdir into \"${doc_dir}\"!"
		sphinx-build -b html source build || die "Building documentation failed!"
	fi
}

src_install() {
	use doc && local HTML_DOCS=( "${S}/docs/build/." )
	default
	meson_src_install
}
