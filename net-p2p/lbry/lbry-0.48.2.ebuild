# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A browser for the LBRY network, a digital marketplace controlled by its users."
HOMEPAGE="https://lbry.com/"
SRC_URI="https://github.com/lbryio/lbry-desktop/releases/download/v0.48.2/LBRY_0.48.2.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-libs/libXtst
	dev-libs/nss
	x11-libs/libnotify
	dev-libs/libappindicator
	gnome-base/gconf
"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	rm "${S}"/control.tar.gz
	unpack "${S}"/data.tar.xz
	rm data.tar.xz
	rm debian-binary
}

src_install() {
	mv * "${D}" || die
	ls -al "${D}"
	rm -rd "${D}/usr/share/doc/lbry"
	fperms 0755 /opt/LBRY/lbry || die
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
