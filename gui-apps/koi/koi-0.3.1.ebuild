# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Theme scheduling for the KDE Plasma Desktop"
HOMEPAGE="https://github.com/baduhai/Koi"
SRC_URI="
	https://github.com/baduhai/Koi/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/Koi-${PV}/src"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets,xml]
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kconfig:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kwidgetsaddons:6
"
RDEPEND="${DEPEND}
"
BDEPEND="
	kde-frameworks/extra-cmake-modules
"
