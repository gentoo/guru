# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="6463a3931e86c4a99ff022d091ad5a7d49e202b1"
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

DEPEND="
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kparts-${KFMIN}:5
"
RDEPEND="${DEPEND}"

src_test() {
	export QT_QPA_PLATFORM=offscreen
	ecm_src_test
}
