# Copyright 1999-2028 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="3c01c088e6b54e89f382bce56d49733a9969ef09"

inherit cmake optfeature

DESCRIPTION="Quantifier Elimination by Partial Cylindrical Algebraic Decomposition"
HOMEPAGE="
	https://www.usna.edu/Users/cs/wcbrown/qepcad/B/QEPCAD.html
	https://github.com/Alessandro-Barbieri/qepcad
"
SRC_URI="https://github.com/Alessandro-Barbieri/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}/qesource"

LICENSE="MIT"
SLOT="0"
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
	echo "qe=/" > 99-qepcad || die
	doenvd 99-qepcad
}

pkg_postinst() {
	optfeature "allowing qepcad to use singular" sci-mathematics/singular
}
