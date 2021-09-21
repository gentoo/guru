# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="16adcdb6413b41489c47637a71a630021ea43a16"
ECM_TEST="forceoptional"
KFMIN=5.77.0
QTMIN=5.4.0
inherit ecm

DESCRIPTION="KPart for viewing text/gemini files"
HOMEPAGE="https://gitlab.com/tobiasrautenkranz/geminipart"
SRC_URI="https://gitlab.com/tobiasrautenkranz/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="konqueror"

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
RDEPEND="${DEPEND}
	konqueror? (
		kde-apps/konqueror:5
		kde-misc/kio-gemini:5
	)
"

src_test() {
	export QT_QPA_PLATFORM=offscreen
	ecm_src_test
}

src_install() {
	ecm_src_install

	if ! use konqueror ; then
		rm "${ED}"/usr/share/applications/gemini-konqueror.desktop || die
	fi
}
