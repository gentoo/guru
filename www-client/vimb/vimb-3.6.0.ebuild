# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic optfeature savedconfig

DESCRIPTION="A fast, lightweight, vim-like browser based on webkit"
HOMEPAGE="https://fanglingsu.github.io/vimb/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fanglingsu/vimb.git"
else
	SRC_URI="https://github.com/fanglingsu/vimb/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="savedconfig adblock"

DEPEND="
	adblock? ( www-misc/wyebadblock )
	>=net-libs/webkit-gtk-2.20.0:4
	x11-libs/gtk+:3
"
BDEPEND="virtual/pkgconfig"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	restore_config config.def.h
}

src_compile() {
	has_version x11-libs/gtk+:3[-X,wayland] && append-cflags -DFEATURE_NO_XEMBED=1
	emake PREFIX="/usr"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	save_config src/config.def.h
	use adblock && dosym /usr/lib/wyebrowser/adblock.so /usr/lib/vimb/adblock.so
	einstalldocs
}

pkg_postinst() {
	optfeature "media decoding support"  media-plugins/gst-plugins-libav media-libs/gst-plugins-good
}
