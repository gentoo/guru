# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="e44f917bea0e9b982e50fce0de3cfb1e291f3570"
ECM_TEST="forceoptional"
KFMIN=5.98.0
QTMIN=5.4.0
inherit ecm optfeature

DESCRIPTION="KPart for viewing text/gemini files"
HOMEPAGE="https://gitlab.com/tobiasrautenkranz/geminipart"
SRC_URI="https://gitlab.com/tobiasrautenkranz/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kparts-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"
RDEPEND="${DEPEND}"

src_test() {
	export QT_QPA_PLATFORM=offscreen
	ecm_src_test
}

src_prepare() {
	# Konqueror may not be installed, don't make it default text/gemini handler
	sed "/MimeType=/d" -i integration/gemini-konqueror.desktop || die
	ecm_src_prepare
}

pkg_postinst() {
	ecm_pkg_postinst

	optfeature "handling gemini:// URLs in Konqueror browser" \
		"kde-apps/konqueror kde-misc/kio-gemini"
}
