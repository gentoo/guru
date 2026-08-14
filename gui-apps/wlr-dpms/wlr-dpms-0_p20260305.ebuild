# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT=bb86bdee332ddf1f2ceefc04bf73071ac24df3d5

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

PATCHES=( "${FILESDIR}"/makefile-respect-flags.patch )

DOCS=( README )

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
