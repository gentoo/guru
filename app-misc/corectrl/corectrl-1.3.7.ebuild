# Copyright 1999-2023 Gentoo Authors
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

DEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtcharts:5[qml]
	dev-qt/qtsvg:5
	dev-qt/linguist-tools:5
	dev-qt/qtquickcontrols2:5
	dev-libs/quazip
	dev-libs/botan:2
	sys-auth/polkit
	x11-libs/libdrm[video_cards_amdgpu]
	dev-libs/libfmt
	dev-libs/pugixml
	dev-cpp/easyloggingpp
	dev-cpp/units
	test? (
		~dev-cpp/catch-2.13.8
		dev-cpp/trompeloeil
	)
"

BDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-headers-6.6.patch
)
src_configure() {
	local mycmakeargs+=(
		-DBUILD_TESTING=$(usex test ON OFF)
	)
	cmake_src_configure
}
