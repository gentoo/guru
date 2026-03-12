# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature toolchain-funcs

DESCRIPTION="small daemon managing kernel hotplug events, similarly to udevd"
HOMEPAGE="https://skarnet.org/software/mdevd/"
SRC_URI="https://skarnet.org/software/mdevd/${P}.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND=">=dev-libs/skalibs-2.14.5.0:="
DEPEND="${RDEPEND}"

DOCS=( AUTHORS NEWS README doc/ examples )

src_configure() {
	tc-export CC

	# --with-dynlib and --with-sysdeps needs to match skalibs' --dynlibdir and --sysdepdir respectively
	local myconf=(
		--dynlibdir="/$(get_libdir)"
		--libdir="/usr/$(get_libdir)/${PN}"
		--sysconfdir=/etc

		--with-dynlib="/$(get_libdir)"
		--with-sysdeps="/usr/$(get_libdir)/skalibs/"

		--enable-shared
		--disable-allstatic
	)

	# TODO: --enable-nsss
	econf "${myconf[@]}"
}

src_compile() {
	emake AR=$(tc-getAR) RANLIB=$(tc-getRANLIB)
}

pkg_postinst() {
	optfeature "For +/-/& command directives in mdev.conf" dev-lang/execline
}
