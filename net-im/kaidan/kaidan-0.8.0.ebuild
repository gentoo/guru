# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=5.67.0
QTMIN=5.14.0
inherit ecm

DESCRIPTION="A simple, user-friendly Jabber/XMPP client for every device!"
HOMEPAGE="https://www.kaidan.im"
SRC_URI="mirror://kde/unstable/${PN}/${PV}/${P}.tar.xz"

LICENSE="Apache-2.0 CC-BY-SA-4.0 GPL-3+ GPL-3-with-openssl-exception MIT"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="kde nls"

BDEPEND="
	nls? ( >=dev-qt/linguist-tools-${QTMIN}:5 )
"
DEPEND="
	>=dev-qt/qtconcurrent-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtlocation-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5[qml]
	>=dev-qt/qtnetwork-${QTMIN}:5[ssl]
	>=dev-qt/qtpositioning-${QTMIN}:5[qml]
	>=dev-qt/qtquickcontrols-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:5
	>=media-libs/zxing-cpp-1.0.8
	>=net-libs/qxmpp-1.3.0
	kde? ( >=kde-frameworks/knotifications-${KFMIN}:5 )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-no-knotifications.patch )

src_configure() {
	local mycmakeargs=(
		-DI18N=$(usex nls)
		-DBUILD_TESTS=$(usex test)
		-DUSE_KNOTIFICATIONS=$(usex kde)
		# compile QML at build time
		-DQUICK_COMPILER=ON
	)
	ecm_src_configure
}
