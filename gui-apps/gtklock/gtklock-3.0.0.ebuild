# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="GTK-based lockscreen for Wayland"
HOMEPAGE="https://github.com/jovanlanik/gtklock"
SRC_URI="https://github.com/jovanlanik/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="man"
RDEPEND="
	sys-libs/pam
	x11-libs/gtk+:3[wayland]
	gui-libs/gtk-session-lock
"
DEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-build/meson
	man? ( app-text/scdoc )
"

src_configure() {
        local emesonargs=(
                $(meson_feature man man-pages)
		)
        meson_src_configure
}
