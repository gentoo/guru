# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Core control application"
HOMEPAGE="https://gitlab.com/corectrl/corectrl"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/corectrl/corectrl.git"
else
	SRC_URI="https://gitlab.com/corectrl/corectrl/-/archive/v${PV}/corectrl-v${PV}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	dev-libs/botan
	dev-libs/pugixml
	dev-libs/spdlog
	dev-libs/quazip
	dev-qt/qtcharts:5[qml]
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	sys-auth/polkit
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/units
	dev-qt/linguist-tools:5
	dev-qt/qtsvg:5
	x11-libs/libdrm[video_cards_amdgpu]
	test? (
		>=dev-cpp/catch-3.5.2
		dev-cpp/trompeloeil
	)
"

RDEPEND="${COMMON_DEPEND}
	dev-libs/glib
	dev-qt/qtquickcontrols2
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
	)
	cmake_src_configure
}
