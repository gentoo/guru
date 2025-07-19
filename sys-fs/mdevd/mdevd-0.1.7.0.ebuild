# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature toolchain-funcs

DESCRIPTION="small daemon managing kernel hotplug events, similarly to udevd"
HOMEPAGE="https://skarnet.org/software/mdevd/"
SRC_URI="https://skarnet.org/software/mdevd/${P}.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-libs/skalibs-2.14.4.0:="
DEPEND="${RDEPEND}"

DOCS=( AUTHORS NEWS README doc/ examples )

src_configure() {
	econf \
		--with-sysdeps=/usr/$(get_libdir)/skalibs/ \
		--enable-shared \
		--disable-allstatic \
		--with-pkgconfig

	# TODO: --enable-nsss
}

src_compile() {
	emake AR=$(tc-getAR) RANLIB=$(tc-getRANLIB)
}

pkg_postinst() {
	optfeature "For +/-/& command directives in mdev.conf" dev-lang/execline
}
