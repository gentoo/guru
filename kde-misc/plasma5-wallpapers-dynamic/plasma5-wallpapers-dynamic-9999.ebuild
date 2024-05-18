# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN="5.66.0"
QTMIN="5.12.0"

inherit ecm

DESCRIPTION="A KDE Plasma wallpaper plugin to set your wallpaper based on the time of day."
HOMEPAGE="https://github.com/zzag/plasma5-wallpapers-dynamic"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zzag/plasma5-wallpapers-dynamic.git"
else
	SRC_URI="https://github.com/zzag/plasma5-wallpapers-dynamic/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
fi

LICENSE="GPL-3 LGPL-3 MIT"
SLOT="0"

DEPEND="
	>=dev-qt/qtconcurrent-${QTMIN}:5
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtpositioning-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kpackage-${KFMIN}:5
	>=kde-plasma/libplasma-${KFMIN}:5
	>=media-libs/libheif-1.3.0
	>=kde-frameworks/kirigami-${KFMIN}:5
	media-libs/libexif
"
RDEPEND="${DEPEND}"
