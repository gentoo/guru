# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wayfire"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/WayfireWM/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+wf-config +wlroots +elogind systemd debug"

DEPEND="
		dev-libs/libevdev
		dev-libs/libinput
		media-libs/glm
		media-libs/mesa:=[gles2,wayland,X]
		media-libs/libjpeg-turbo
		media-libs/libpng
		media-libs/freetype:=[X]
		x11-libs/libdrm
		x11-libs/gtk+:3=[wayland,X]
		x11-libs/cairo:=[X,svg]
		x11-libs/libxkbcommon:=[X]
		x11-libs/pixman
		gui-libs/gtk-layer-shell
		wf-config? ( ~gui-apps/wf-config-${PV} )
		wlroots? ( >=gui-libs/wlroots-0.10.0[elogind=,systemd=,X] )
"

RDEPEND="
		${DEPEND}
		elogind? ( sys-auth/elogind )
		systemd? ( sys-apps/systemd )
		x11-misc/xkeyboard-config
"

BDEPEND="
		${DEPEND}
		virtual/pkgconfig
		>=dev-libs/wayland-protocols-1.14
"

src_configure(){
	local emesonargs=(
		-Duse_system_wfconfig=$(usex wf-config enabled disabled)
		-Duse_system_wlroots=$(usex wlroots enabled disabled)
	)
	if use debug; then
		emesonargs+=(
			"-Db_sanitize=address,undefined"
		)
	fi
	meson_src_configure
}

pkg_preinst() {
	if ! use systemd && ! use elogind; then
		fowners root:0 /usr/bin/wayfire
		fperms 4511 /usr/bin/wayfire
	fi
}

src_install() {
	default
	meson_src_install
	einstalldocs

	insinto "/usr/share/wayland-sessions/"
	insopts -m644
	doins wayfire.desktop

	dodoc wayfire.ini
}

pkg_postinst() {
	elog "Wayfire has been installed but the session cannot be used"
	elog "until you install a configuration file. The default config"
	elog "file is installed at \"/usr/share/doc/${P}/wayfire.ini.bz2\""
	elog "To install the file execute"
	elog "\$ mkdir -p ~/.config && bzcat /usr/share/doc/${P}/wayfire.ini.bz2 > ~/.config/wayfire.ini"
}
