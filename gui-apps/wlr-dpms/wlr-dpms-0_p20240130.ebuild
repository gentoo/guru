# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

COMMIT=d0e64122e2b2718da26223e8add3211f5dbeb23a

DESCRIPTION="change output power modes in wlroots compositors"
HOMEPAGE="https://sr.ht/~dsemy/wlr-dpms/"
SRC_URI="https://git.sr.ht/~dsemy/wlr-dpms/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( README )

src_configure() {
	# from Makefile
	append-cflags -Wno-unused-parameter -Wno-strict-prototypes -Wno-incompatible-pointer-types
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
