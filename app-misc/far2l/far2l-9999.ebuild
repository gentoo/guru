# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"

inherit cmake xdg wxwidgets

DESCRIPTION="Linux port of FAR Manager v2"
HOMEPAGE="https://github.com/elfmz/far2l"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/elfmz/far2l"
	EGIT_BRANCH="master"
else
	MY_PV="v_${PV/_beta/}"
	MY_P="${PN}-${MY_PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/elfmz/far2l/archive/${MY_PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+archive +chardet +colorer nfs samba sftp +ssl webdav wxwidgets X"
RESTRICT="mirror"

RDEPEND="
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER} )
	X? (
		x11-libs/libX11
		x11-libs/libXi
	)
	archive? (
		dev-libs/libpcre2
		app-arch/libarchive
	)
	chardet? ( app-i18n/uchardet )
	colorer? ( dev-libs/libxml2 )
	nfs? ( net-fs/libnfs )
	samba? ( net-fs/samba )
	sftp? ( net-libs/libssh[sftp] )
	ssl? ( dev-libs/openssl )
	webdav? ( net-libs/neon )"

DEPEND="${RDEPEND}"

DOCS=( README.md )

pkg_setup() {
	if use wxwidgets; then
		setup-wxwidgets
	fi
}

src_prepare() {
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_askpass)::" \
		-i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_sudoapp)::" \
		-i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/.*::" \
		-i "${S}"/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSEWX="$(usex wxwidgets)"
		-DUSEUCD=$"$(usex chardet)"
		-DCOLORER="$(usex colorer)"
#		FIXME: add python plugins support
#		We need pcpp for this
#		-DPYTHON="$(usex python)"
		-DBUILD_SHARED_LIBS=OFF
	)

	cmake_src_configure
}

src_install(){
	cmake_src_install
	einstalldocs
	dosym "../../bin/far2l" "usr/lib/far2l/far2l_askpass"
	dosym "../../bin/far2l" "usr/lib/far2l/far2l_sudoapp"
}
