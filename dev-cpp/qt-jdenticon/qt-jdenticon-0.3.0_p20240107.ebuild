# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_COMMIT="1e7013d64fd081d76e4ce69f2693129c817fd8f1"
DESCRIPTION="Qt5 / C++14 Port of Jdenticon"
HOMEPAGE="https://github.com/Nheko-Reborn/qt-jdenticon"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="6"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase:6[gui]
"
DEPEND="${RDEPEND}"
