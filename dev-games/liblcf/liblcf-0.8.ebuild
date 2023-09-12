# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Library to handle RPG Maker 2000/2003 and EasyRPG projects"
HOMEPAGE="https://easyrpg.org/
	https://github.com/EasyRPG/liblcf"
SRC_URI="https://easyrpg.org/downloads/player/${PV}/${P}.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc tools"

RDEPEND="
	dev-libs/expat
	dev-libs/icu:=
"
DEPEND="${RDEPEND}"
BDEPEND="doc? (
				app-doc/doxygen
				media-gfx/graphviz[svg]
			  )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=True
		-DLIBLCF_UPDATE_MIMEDB=False
		-DLIBLCF_ENABLE_TOOLS=$(usex tools)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	# Why do we have to build this explicitly :/
	use doc && cmake_build liblcf_doc
}

src_test() {
	cmake_build check
}

src_install() {
	cmake_src_install
	if use doc; then
		docinto /usr/share/doc/${PF}/html
		dodoc -r doc/*
	fi
}
