# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Disk benchmarking tool"
HOMEPAGE="https://github.com/JonMagon/KDiskMark"
SRC_URI="https://github.com/JonMagon/KDiskMark/releases/download/${PV}/${P}-source.tar.gz"

inherit cmake xdg

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets]
	sys-auth/polkit-qt[qt6]
"
DEPEND="
	${COMMON_DEPEND}
	kde-frameworks/extra-cmake-modules
"
RDEPEND="
	${COMMON_DEPEND}
	sys-block/fio[aio]
	x11-themes/hicolor-icon-theme
"
BDEPEND="dev-qt/qttools:6[linguist]"
