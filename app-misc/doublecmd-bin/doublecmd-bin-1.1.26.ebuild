# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

MY_PN="doublecmd"
DESCRIPTION="Free cross platform open source file manager with two panels side by side."
HOMEPAGE="https://doublecmd.sourceforge.io/"

SRC_URI="amd64? (
		gtk? ( https://downloads.sourceforge.net/${MY_PN}/${MY_PN}-${PV}.gtk2.x86_64.tar.xz )
		qt5?  ( https://downloads.sourceforge.net/${MY_PN}/${MY_PN}-${PV}.qt.x86_64.tar.xz )
		qt6?  ( https://downloads.sourceforge.net/${MY_PN}/${MY_PN}-${PV}.qt6.x86_64.tar.xz )
	)
	x86? (
		gtk? ( https://downloads.sourceforge.net/${MY_PN}/${MY_PN}-${PV}.gtk2.i386.tar.xz )
		qt5?  ( https://downloads.sourceforge.net/${MY_PN}/${MY_PN}-${PV}.qt.i386.tar.xz )
	)"

S="${WORKDIR}/${MY_PN}"

# Licenses for package and plugins
LICENSE="GPL-2+ LGPL-2-with-linking-exception LGPL-2.1+ LGPL-3 GPL-1 freedist"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE="gtk qt5 qt6"
REQUIRED_USE=" ^^ ( gtk qt5 qt6 ) "

QA_PREBUILT="
	*/doublecmd
	*/libQt5Pas.so.1
	*/libQt6Pas.so.6
	*/libunrar.so
	*/plugins/.*
"

## "ldd doublecmd" output show linking to some libraries provided by sys-libs/glibc:2.2
## (maybe virtual/libc-1) and no libraries of sys-libs/ncurses (that removed here).
## x11-libs/X11 is optional dependency of dev-qt/qtgui:5 by [xcb] or [X]
## therefore it is mentioned here explicitly.
RDEPEND="
	dev-libs/glib:2
	sys-apps/dbus
	x11-libs/libX11
	virtual/libc
	gtk? ( x11-libs/gtk+:2 )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
	)
	qt6? (
		dev-qt/qtbase:6[gui,widgets]
	)
"

src_install(){
	insinto "/opt/${PN}"
	doins -r "${S}/."

	# Remove doublecmd.inf to use config from user home directory
	rm "${ED}/opt/${PN}"/settings/doublecmd.inf || die

	exeinto "/opt/${PN}"
	doexe "${S}/${MY_PN}"
	make_wrapper ${MY_PN} "/opt/${PN}/${MY_PN}" "" "/opt/${PN}" "/opt/bin/"

	doicon -s 48 ${MY_PN}.png
	make_desktop_entry "${MY_PN}" "Double Commander" "${MY_PN}" "Utility;" || die "Failed making desktop entry!"
}
