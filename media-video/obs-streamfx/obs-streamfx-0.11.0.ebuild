# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

M_PV="0.11.0"

DESCRIPTION="OBS® Studio plugin which adds many new effects."
HOMEPAGE="https://github.com/Xaymar/obs-StreamFX"

EGIT_REPO_URI="https://github.com/Xaymar/obs-StreamFX.git"
EGIT_BRANCH="${M_PV}"

KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
RDEPEND="
	media-video/obs-studio
"

src_prepare() {
	default

	#fix CMakeLists.txt libdir
	sed -i 's|"lib/obs-plugins/"|"${CMAKE_INSTALL_LIBDIR}/obs-plugins/"|g' "${S}/CMakeLists.txt"
	cmake_src_prepare
}

src_configure() {

	local mycmakeargs+=(
		-DSTRUCTURE_PACKAGEMANAGER=TRUE
		-DPACKAGE_NAME="obs-streamfx"
	)

	cmake_src_configure
}
