# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="a00ebc5bd6d943823a702943cc96684f7c051531"
ECM_HANDBOOK="forceoptional"
ECM_TEST="true"
KFMIN=6.0.0
QTMIN=6.0.0
inherit ecm

DESCRIPTION="Gemini KIO worker"
HOMEPAGE="https://gitlab.com/tobiasrautenkranz/kio-gemini"
SRC_URI="https://gitlab.com/tobiasrautenkranz/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2+"
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~x86"

# Tests fail if kio-gemini is not installed yet.
RESTRICT="test"

RDEPEND="
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
"
DEPEND="${RDEPEND}
	test? (
		>=dev-qt/qtbase-${QTMIN}:6[network,ssl,widgets]
	)
"

src_configure() {
	local mycmakeargs=(
		-DHTML_INSTALL_DIR="${EPREFIX}/usr/share/help"
	)
	ecm_src_configure
}

src_install() {
	ecm_src_install

	if use handbook; then
		mkdir -p "${ED}/usr/share/help/en/kioworker6" || die
		mv "${ED}/usr/share/help/en/gemini" "${ED}/usr/share/help/en/kioworker6/" || die
	fi
}
