# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SDDM configuration editor"
HOMEPAGE="https://qtilities.github.io/"
SRC_URI="https://github.com/qtilities/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase
	sys-auth/polkit
	x11-misc/sddm
"
DEPEND="${RDEPEND} "
BDEPEND="
	dev-build/cmake
	dev-qt/qttools
	dev-build/qtilitools
	dev-qt/linguist-tools
"
