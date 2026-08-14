# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# minimum taken from CMakeLists.txt
QTMIN=6.4.0
KFMIN=6.0.0
inherit ecm

DESCRIPTION="Desktop switching utility"
HOMEPAGE="https://github.com/dhruv8sh/kara"
SRC_URI="https://github.com/dhruv8sh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,widgets]
	dev-qt/qtdeclarative:6
	kde-frameworks/ki18n:6
	kde-frameworks/kservice:6
	kde-frameworks/kwindowsystem:6
	kde-plasma/libplasma:6
	kde-plasma/plasma-activities:6
	kde-plasma/plasma-workspace:6
	kde-plasma/kwin:6
"
RDEPEND="${DEPEND}
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfig:6[qml]
	kde-frameworks/kdeclarative:6
	kde-frameworks/kirigami:6
	kde-plasma/plasma5support:6
"
