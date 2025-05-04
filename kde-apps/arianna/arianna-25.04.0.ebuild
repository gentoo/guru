# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_TEST="forceoptional"
KFMIN=6.3.0
QTMIN=6.6.0
inherit ecm gear.kde.org

DESCRIPTION="ebook reader by KDE"
HOMEPAGE="https://apps.kde.org/arianna/"

LICENSE="GPL-3"
SLOT="6"
KEYWORDS="~amd64"
IUSE="test"
PATCHES=(
	"${FILESDIR}"/cmakelists.patch
)

RDEPEND="
	sys-devel/gettext
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,sql,widgets,xml]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-qt/qtwebsockets-${QTMIN}:6
	>=dev-qt/qthttpserver-${QTMIN}:6[websockets]
	dev-libs/kirigami-addons:6
	>=kde-frameworks/baloo-${KFMIN}:6
	>=kde-frameworks/karchive-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kquickcharts-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:6

"
DEPEND="${RDEPEND}"

BDEPEND="test? ( dev-util/reuse )"

src_configure() {
	local mycmakeargs=(
		-G Ninja
		-DCMAKE_BUILD_TYPE=MinSizeRel
		-DBUILD_TESTING=OFF
	)

	ecm_src_configure
}
