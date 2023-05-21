# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=5.67.0
QTMIN=5.15.0
inherit ecm

DESCRIPTION="User-friendly and modern chat app for every device"
HOMEPAGE="https://www.kaidan.im"
SRC_URI="mirror://kde/unstable/${PN}/${P}.tar.xz"

LICENSE="Apache-2.0 CC-BY-SA-4.0 GPL-3+ GPL-3-with-openssl-exception MIT"
SLOT="5"
KEYWORDS="~amd64"
IUSE="kde nls"

DEPEND="
	>=dev-libs/kirigami-addons-0.7:5
	>=dev-qt/qtconcurrent-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtlocation-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5[qml]
	>=dev-qt/qtnetwork-${QTMIN}:5[ssl]
	>=dev-qt/qtpositioning-${QTMIN}:5[qml]
	>=dev-qt/qtquickcontrols-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/kitemviews-${KFMIN}:5
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:5
	media-libs/kquickimageeditor:5
	media-libs/zxing-cpp:=
	>=net-libs/qxmpp-1.5.0[omemo]
	kde? ( >=kde-frameworks/knotifications-${KFMIN}:5 )
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-qt/linguist-tools-${QTMIN}:5"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
		-DUSE_KNOTIFICATIONS=$(usex kde)

		# compile QML at build time
		-DQUICK_COMPILER=ON
	)
	ecm_src_configure
}

src_test() {
	local myctestargs=(
		# needs network
		-E PublicGroupChatTest
	)
	ecm_src_test
}
