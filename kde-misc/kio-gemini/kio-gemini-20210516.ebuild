# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="679b4b9125e9980aea22dace35afd76a5ca9e85e"
ECM_HANDBOOK="forceoptional"
KFMIN=5.38.0
QTMIN=5.4.0
inherit ecm

DESCRIPTION="Gemini KIO slave"
HOMEPAGE="https://gitlab.com/tobiasrautenkranz/kio-gemini"
SRC_URI="https://gitlab.com/tobiasrautenkranz/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
"
RDEPEND="${DEPEND}"

src_test() {
	export QT_QPA_PLATFORM=offscreen
	ecm_src_test
}
