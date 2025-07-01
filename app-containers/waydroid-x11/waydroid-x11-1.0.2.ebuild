# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="Launch waydroid in an X11 session, using weston as a nested compositor."
HOMEPAGE="https://github.com/mid-kid/waydroid-x11"

SRC_URI="https://github.com/mid-kid/$PN/releases/download/$PV/$P.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+X drm"

RDEPEND="
	app-containers/waydroid
	dev-libs/weston[X?,drm?]
"

src_configure() {
	local myeconfargs=(
		$(use_enable X x11)
		$(use_enable drm)
	)
	econf "${myeconfargs[@]}"
}
