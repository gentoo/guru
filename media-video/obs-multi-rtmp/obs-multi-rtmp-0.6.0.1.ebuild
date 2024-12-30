# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="OBS Simulcast support plugin"
HOMEPAGE="https://github.com/sorayuki/obs-multi-rtmp"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sorayuki/obs-multi-rtmp.git"
else
	SRC_URI="https://github.com/sorayuki/obs-multi-rtmp/archive/refs/tags/$PV-obs31.tar.gz -> ${P}-obs31.tar.gz"
	KEYWORDS="~amd64"
fi

S="${WORKDIR}/${P}-obs31"

LICENSE="GPL-2"
SLOT="0"
IUSE="+obs-frontend-api +qt"
DEPEND="
	qt? ( dev-qt/qtbase:6 )
	>=media-video/obs-studio-31
"
RDEPEND="
	${DEPEND}
"

PATCHES=(
	"${FILESDIR}/cmake.patch"
)

src_unpack() {
	default

	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	fi
}

src_configure() {
	local mycmakeargs+=(
		-DENABLE_FRONTEND_API=$(usex obs-frontend-api ON OFF)
		-DENABLE_QT=$(usex qt ON OFF)
	)

	cmake_src_configure
}
