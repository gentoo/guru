# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Bibata_Cursor"

DESCRIPTION="Opensource, compact, and material-designed cursor set"
HOMEPAGE="https://github.com/ful1e5/Bibata_Cursor"
SRC_URI="
	https://github.com/ful1e5/${MY_PN}/archive/v1.1.2.tar.gz -> ${P}.tar.gz
	https://github.com/ful1e5/${MY_PN}/releases/download/v${PV}/bitmaps.zip -> ${P}-bitmaps.zip
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/libXcursor"
BDEPEND="dev-python/clickgen"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}" || die "Cannot change dir into '${S}'"
	mkdir -p bitmaps || die "Cannot create 'bitmaps' directory"
	cd bitmaps || "Cannot change dir into '${S}/bitmaps'"
	unpack "${P}-bitmaps.zip"
}

src_prepare() {
	rm -rf themes || die "Cannot remove 'themes' directory"
	eapply_user
}

src_compile() {
	cd builder || die "Cannot change dir into '${S}/builder'"
	emake build_unix
}

src_install() {
	insinto /usr/share/cursors/xorg-x11
	doins -r themes/Bibata-{Modern,Original}-{Amber,Classic,Ice}
}
