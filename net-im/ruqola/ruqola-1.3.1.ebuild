# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VIRTUALX_REQUIRED=test
ECM_TEST=forceoptional
ECM_HANDBOOK=forceoptional
KFMIN=5.80.0
QTMIN=5.15.2
inherit ecm

DESCRIPTION="Rocket.Chat client for the KDE desktop"
HOMEPAGE="https://invent.kde.org/network/ruqola"
SRC_URI="https://invent.kde.org/network/ruqola/-/archive/${PV}/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-2+"
SLOT="0"

IUSE="speech telemetry"

DEPEND="
	dev-libs/qtkeychain
	>=dev-qt/qtmultimedia-${QTMIN}:5[widgets]
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtnetworkauth-${QTMIN}:5
	>=dev-qt/qtwebsockets-${QTMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kcrash-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/knotifyconfig-${KFMIN}:5
	>=kde-frameworks/ktextwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
	>=kde-frameworks/sonnet-${KFMIN}:5
	>=kde-frameworks/syntax-highlighting-${KFMIN}:5
	speech? ( >=dev-qt/qtspeech-${QTMIN}:5 )
	telemetry? ( kde-frameworks/kuserfeedback:5 )
"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package speech Qt5TextToSpeech)
		$(cmake_use_find_package telemetry KUserFeedback)
	)

	ecm_src_configure
}
