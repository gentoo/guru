# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_BUILD_TYPE="Release"
WX_GTK_VER="3.2-gtk3"

MY_PN="wxFormBuilder"
MY_PV="1fa5400695f68ee22718f4a4a28b2fb63f275145"
TICPP_PV="6f45ec628cbf34784bb3b3132c0d00aac8e491c6"

inherit cmake wxwidgets xdg

DESCRIPTION="A wxWidgets GUI Builder"
HOMEPAGE="https://github.com/wxFormBuilder/wxFormBuilder"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${MY_PN}/${MY_PN}.git"
else
	SRC_URI="
		https://github.com/${MY_PN}/${MY_PN}/archive/${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz
		https://github.com/${MY_PN}/ticpp/archive/${TICPP_PV}.tar.gz -> ${PN}-ticpp-${TICPP_PV}.tar.gz
	"
	S="${WORKDIR}/${MY_PN}-${MY_PV}"
	KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]"
DEPEND="${RDEPEND}"

src_prepare() {
	# Remove bundled ticpp and symlink to downloaded ticpp
	rmdir "${S}/third_party/ticpp" || die
	ln -s "${WORKDIR}/ticpp-${TICPP_PV}/" "${S}/third_party/ticpp" || die
	# Disable update-mime-database command, shouldn't be doing this here.
	sed -i "s/NAMES update-mime-database/NAMES echo/g" "${S}"/src/CMakeLists.txt || die
	cmake_src_prepare
}
