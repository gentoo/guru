# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Highly customizable SDDM theme"
HOMEPAGE="https://github.com/uiriansan/SilentSDDM"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uiriansan/SilentSDDM.git"
else
	SRC_URI="https://github.com/uiriansan/SilentSDDM/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/SilentSDDM-${PV}"
fi

LICENSE="GPL-3 OFL-1.1"
SLOT="0"

RDEPEND="
	x11-misc/sddm
	>=dev-qt/qtsvg-6.10.1
	>=dev-qt/qtvirtualkeyboard-6.10.1
	>=dev-qt/qtmultimedia-6.10.1-r1
"

src_install() {
	insinto /usr/share/fonts
	doins -r fonts/redhat-vf fonts/redhat
	insinto /usr/share/sddm/themes/silent
	doins -r Main.qml metadata.desktop qmldir icons configs components backgrounds
}

pkg_postinst() {
	elog "To enable this theme, add the following to /etc/sddm.conf and restart sddm"
	elog ""
	elog "[General]"
	elog "InputMethod=qtvirtualkeyboard"
	elog "GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard"]
	elog ""
	elog "[Theme]"
	elog "Current=silent"
}
