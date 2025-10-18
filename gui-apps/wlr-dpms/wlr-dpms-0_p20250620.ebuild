# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

COMMIT=b6a4aa82d7760d09a3323c93b02e10eb9eb89a3d

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
	append-cflags -std=c99 -Wall -Wextra -Wno-unused-parameter -Wno-strict-prototypes
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
