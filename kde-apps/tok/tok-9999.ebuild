# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qbs

DESCRIPTION="Telegram client built using Kirigami"
HOMEPAGE="https://invent.kde.org/network/tok"
EGIT_REPO_URI="https://invent.kde.org/network/${PN}.git"
#SRC_URI="https://invent.kde.org/network/${PN}/-/archive/${COMMIT}/${MY_P}.tar.gz"
#S="${WORKDIR}/${MY_P}"

LICENSE="|| ( LGPL-3 GPL-2 GPL-3 ) AGPL-3+ GPL-3+ LGPL-2.1+ LGPL-3+"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-libs/icu:=
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kdbusaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kirigami:5
	kde-frameworks/kquickchatcomponents:5
	kde-frameworks/knotifications:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/syntax-highlighting:5
	media-libs/rlottie:=
	net-libs/td
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-misc/jq
	dev-util/cmake
"

src_prepare() {
	default

	# undefined reference to QmlCacheGeneratedCode
	sed "/Qt.quick.useCompiler/d" -i src/Tok.qbs || die
}
