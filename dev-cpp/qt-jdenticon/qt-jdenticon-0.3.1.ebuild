# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt5 / C++14 Port of Jdenticon"
HOMEPAGE="https://github.com/Nheko-Reborn/qt-jdenticon"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="6"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase:6[gui]
"
DEPEND="${RDEPEND}"
