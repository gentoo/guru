# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="f79047ad332ee378d876dcbdc8725c3b1f5f7bb7"

inherit cmake optfeature

DESCRIPTION="Quantifier Elimination by Partial Cylindrical Algebraic Decomposition"
HOMEPAGE="
	https://www.usna.edu/Users/cs/wcbrown/qepcad/B/QEPCAD.html
	https://github.com/Alessandro-Barbieri/qepcad
"
SRC_URI="https://github.com/Alessandro-Barbieri/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}/qesource"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/freeglut
	media-libs/glu
	media-libs/libglvnd
	sci-libs/saclib:=
	sys-libs/readline
"
DEPEND="${RDEPEND}"

DOCS=( README LOG )

src_configure() {
	export qe="${S}"
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake_src_configure
}

src_install() {
	einstalldocs
	cmake_src_install
	docinto cad2d
	dodoc cad2d/README
}

pkg_postinst() {
	optfeature "allowing qepcad to use singular" sci-mathematics/singular
}
