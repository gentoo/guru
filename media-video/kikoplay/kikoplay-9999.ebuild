# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GIT_PN="KikoPlay"

inherit qmake-utils xdg

DESCRIPTION="KikoPlay is a full-featured danmu player"
HOMEPAGE="
	https://kikoplay.fun
	https://github.com/Protostars/KikoPlay
"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Protostars/${GIT_PN}.git"
else
	SRC_URI="https://github.com/Protostars/${GIT_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
	S="${WORKDIR}/${GIT_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-lang/lua:5.3
	dev-libs/qhttpengine:5
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	media-video/mpv[libmpv,-luajit]
	net-misc/aria2
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	media-gfx/imagemagick
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.6.0-desktop.patch # Add a desktop file
	"${FILESDIR}"/${PN}-0.6.0-home.patch # Fix config file path
)

src_prepare() {
	default
	# Fix lua link problem, link to lua5.3 to fix bug
	sed -i "s/-llua/-llua5.3/" KikoPlay.pro || die "Could not fix lua link"
	echo "target.path += /usr/bin" >> KikoPlay.pro || die "Could not fix install path"
	echo "INSTALLS += target icons desktop" >> KikoPlay.pro || die "Could not fix install target"
	echo "unix:icons.path = /usr/share/pixmaps" >> KikoPlay.pro || die "Could not fix install icon PATH"
	echo "unix:desktop.path = /usr/share/applications" >> KikoPlay.pro || die "Could not fix install desktop PATH"
	echo "unix:icons.files = kikoplay.png kikoplay.xpm" >> KikoPlay.pro || die "Could not fix install desktop PATH"
	echo "unix:desktop.files = kikoplay.desktop" >> KikoPlay.pro || die "Could not fix install desktop PATH"
	echo "DEFINES += CONFIG_HOME_DATA" >> KikoPlay.pro || die "Could not set defines"
	convert kikoplay.ico kikoplay.png || die "Could not create PNG icon"
	convert kikoplay.ico kikoplay.xpm || die "Could not create XPM icon"
}

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_install() {
	# Can't use default, set INSTALL_ROOT
	emake INSTALL_ROOT="${D}" install
}
