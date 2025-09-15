# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT="d3a0c92d9ca232860680165271bc78be111c6961"

inherit cmake xdg

DESCRIPTION="Pop-up with exit options for MX Fluxbox"
HOMEPAGE="https://github.com/MX-Linux/exit-options"
SRC_URI="https://github.com/MX-Linux/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qttools:6[linguist]
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	dev-build/ninja
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/"${PN}"-cmake.patch
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON
		-DNO_DEBUG_ON_CONSOLE=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	einstalldocs

	# debian/install ...

	insinto /usr/share/"${PN}"/conf
	doins configs_alt/*

	insinto /etc/
	doins "${PN}".conf

	insinto /usr/share/"${PN}"
	doins -r icons/*
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
