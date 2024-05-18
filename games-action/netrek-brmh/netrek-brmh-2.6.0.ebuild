# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs

DESCRIPTION="brmh client for netrek"
HOMEPAGE="https://netrek.org"
SRC_URI="https://github.com/bgloyer/netrek-client-brmh/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/netrek-client-brmh-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-base/xorg-proto
	x11-libs/libX11
	x11-libs/libXmu
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	x11-misc/imake
	x11-misc/gccmakedep
"

src_configure() {
	xmkmf || die
	emake depend \
		CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		LOCAL_LDFLAGS="${LDFLAGS}"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		LOCAL_LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin netrek
}
