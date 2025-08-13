# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="842ed7d533e646ec34652ed7d2e7ff39ec7c3b34"
ECM_TEST="forceoptional"
KFMIN=6.0.0
QTMIN=6.0.0
inherit ecm optfeature

DESCRIPTION="KPart for viewing text/gemini files"
HOMEPAGE="https://gitlab.com/tobiasrautenkranz/geminipart"
SRC_URI="https://gitlab.com/tobiasrautenkranz/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2.1+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	!kde-misc/geminipart:5
	>=dev-qt/qt5compat-${QTMIN}:6
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
"
DEPEND="${RDEPEND}"

src_test() {
	export QT_QPA_PLATFORM=offscreen
	ecm_src_test
}

src_prepare() {
	# Konqueror may not be installed, don't make it default text/gemini handler
	sed "/MimeType=/d" -i integration/gemini-konqueror.desktop || die
	ecm_src_prepare
}

src_install() {
	ecm_src_install

	mv "${ED}/usr/share/kservices5" "${ED}/usr/share/kf6" || die
}

pkg_postinst() {
	ecm_pkg_postinst

	optfeature "handling gemini:// URLs in Konqueror browser" \
		"kde-apps/konqueror kde-misc/kio-gemini"
}
