# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Vietnamese Bamboo input method for Fcitx5 (Lotus branch)"
HOMEPAGE="https://github.com/LotusInputMethod/fcitx5-lotus"

BAMBOO_CORE_COMMIT="9197d2cc164380a80d219f12cc90576ff2fbf5e6"
BAMBOO_URI="https://github.com/LotusInputMethod/bamboo-core/archive"

SRC_URI="
	https://github.com/LotusInputMethod/fcitx5-lotus/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${BAMBOO_URI}/${BAMBOO_CORE_COMMIT}.tar.gz -> bamboo-core-${BAMBOO_CORE_COMMIT}.tar.gz
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=app-i18n/fcitx-5.0.14:5
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	rmdir bamboo/bamboo-core || die
	mv "${WORKDIR}/bamboo-core-${BAMBOO_CORE_COMMIT}" bamboo/bamboo-core || die

	cmake_src_prepare
}
