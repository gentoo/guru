# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

DESCRIPTION="Monitor and control your cooling and other devices"
HOMEPAGE="https://gitlab.com/coolercontrol/coolercontrol"
SRC_URI="
	https://gitlab.com/coolercontrol/coolercontrol/-/archive/${PV}/${P}.tar.bz2
"
S="${WORKDIR}/coolercontrol-${PV}/coolercontrol/"

LICENSE="GPL-3+ CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,widgets]
	dev-qt/qtwebchannel:6
	dev-qt/qtwebengine:6[widgets]
"
RDEPEND="
	${DEPEND}
	sys-apps/coolercontrold
"

src_install() {
	cmake_src_install
	einstalldocs

	domenu ../packaging/metadata/org.coolercontrol.CoolerControl.desktop
	doicon -s 256 ../packaging/metadata/org.coolercontrol.CoolerControl.png
	doicon -s scalable ../packaging/metadata/org.coolercontrol.CoolerControl.svg
	insinto /usr/share/icons/hicolor/symbolic/apps
	doins  ../packaging/metadata/org.coolercontrol.CoolerControl-symbolic.svg
	insinto /usr/share/metainfo
	doins ../packaging/metadata/org.coolercontrol.CoolerControl.metainfo.xml
}
