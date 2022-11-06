# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.91.0
QTMIN=5.15.2
VIRTUALX_REQUIRED=test
inherit ecm

DESCRIPTION="Convergent visual components for Kirigami-based applications"
HOMEPAGE="https://invent.kde.org/libraries/kirigami-addons"
SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) LGPL-2+ LGPL-2.1+"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-qt/qtmultimedia-${QTMIN}:5[gstreamer,qml(+)]
		media-libs/gst-plugins-base:1.0[ogg,vorbis]
		media-libs/gst-plugins-bad:1.0
		media-libs/gst-plugins-good:1.0
		x11-themes/sound-theme-freedesktop
	)
"
