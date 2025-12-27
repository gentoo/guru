# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit xdg distutils-r1 desktop

DESCRIPTION="WhatsApp desktop application written in PyQt6 + PyQt6-WebEngine"
HOMEPAGE="https://github.com/rafatosta/zapzap"

SRC_URI="https://github.com/rafatosta/zapzap/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyqt6[dbus]
	dev-python/pyqt6-webengine
"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install
	doicon -s scalable share/icons/com.rtosta.zapzap.svg
	domenu share/applications/com.rtosta.zapzap.desktop
	insinto /usr/share/metainfo
	doins share/metainfo/com.rtosta.zapzap.appdata.xml
}
