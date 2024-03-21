# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Disk benchmarking tool"
HOMEPAGE="https://github.com/JonMagon/KDiskMark"
SRC_URI="https://github.com/JonMagon/KDiskMark/releases/download/${PV}/KDiskMark-${PV}-source.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/KDiskMark-${PV}"

inherit cmake

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/linguist-tools:5
	dev-qt/qtdbus:5
	kde-frameworks/extra-cmake-modules
	sys-auth/polkit-qt
	sys-block/fio[aio]"
RDEPEND="${DEPEND}"

src_configure() {
	cmake_src_configure
}
