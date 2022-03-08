# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="MPRIS plugin for mpv"
HOMEPAGE="https://github.com/hoyon/mpv-mpris"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hoyon/${PN}.git"
else
	SRC_URI="https://github.com/hoyon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
fi

SLOT="0"
LICENSE="MIT"
IUSE="+autoload test"

RDEPEND="
	dev-libs/glib:2
	media-video/mpv:=[cplugins,libmpv]
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? (
		app-misc/jq
		app-shells/bash
		app-text/jo
		media-sound/playerctl
		net-misc/socat
		sys-apps/dbus
		virtual/awk
		x11-apps/xauth
		x11-misc/xvfb-run
		x11-themes/sound-theme-freedesktop
	)
"
RESTRICT="!test? ( test )"

src_compile() {
	tc-export CC
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_test() {
	emake test
}

src_install() {
	newlib.so mpris.so ${PN}.so
	use autoload && dosym -r /usr/$(get_libdir)/${PN}.so /etc/mpv/scripts/mpris.so
	einstalldocs
}

pkg_postinst() {
	if ! use autoload; then
		elog
		elog "The plugin has not been installed to /etc/mpv/scripts for autoloading."
		elog "You have to activate it manually by passing"
		elog " '${EPREFIX}/usr/$(get_libdir)/${PN}.so'"
		elog "as a script option to mpv or symlinking the library to 'scripts' in your mpv"
		elog "config directory."
		elog "Alternatively, activate the autoload use flag."
		elog
	fi
}
