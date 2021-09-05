# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="2e2890cacc1fe6e25f11255aecda063717f71f5b"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Tools from Pugh et al.'s for constraint-based compiler tools"
HOMEPAGE="https://github.com/davewathaverford/the-omega-project"
SRC_URI="https://github.com/davewathaverford/the-omega-project/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug htmldoc gui petit"

DEPEND="
	petit? (
		gui? (
			x11-libs/motif
		)
	)
"
RDEPEND="${DEPEND}"
BDEPEND="htmldoc? ( dev-tex/latex2html )"

DOCS=(
	omega_lib/doc/interface.dvi
	omega_calc/doc/calculator.dvi
	README
)
PATCHES=(
	"${FILESDIR}/${PN}-respect-flags.patch"
	"${FILESDIR}/${PN}-include-Exit-h-in-util-h.patch"
	"${FILESDIR}/${PN}-remove-default-argument-of-friend-function.patch"
	"${FILESDIR}/${PN}-fix-fpermissive-errors.patch"
)

src_prepare() {
	default
	append-cxxflags '-DSTILL_CHECK_MULT=1'
	use debug || append-cxxflags '-DNDEBUG'
	use gui || append-cxxflags '-DBATCH_ONLY_PETIT'
	tc-export CXX RANLIB
	sed -e "s|/usr/lib64|/usr/$(get_libdir)|g" -i Makefile.config || die
}

src_compile() {
	emake depend
	emake oc
	use petit && emake petit

	if use htmldoc; then
		pushd omega_calc/doc || die
		emake calculator.html
		popd || die
		HTML_DOCS+=( omega_calc/doc/calculator.html )
	fi
}

src_install() {
	mkdir -p "${D}/usr/include/omega" || die
	DESTDIR="${D}" emake install
	einstalldocs
	docinto petit
	use petit && dodoc -r petit/doc petit/*README
}
