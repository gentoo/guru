# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

WX_GTK_VER="3.2-gtk3"

inherit cmake optfeature python-single-r1 wxwidgets xdg

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
IUSE="+archive aws +chardet +colorer mtp nfs python rar samba sdl sftp +ssl webdav wxwidgets X"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"
RESTRICT="mirror"

RDEPEND="
	archive? ( app-arch/libarchive )
	aws? (
		dev-libs/openssl:0=
		net-libs/neon[ssl]
	)
	chardet? ( app-i18n/uchardet )
	colorer? ( dev-libs/libxml2 )
	nfs? ( net-fs/libnfs )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/cffi[${PYTHON_USEDEP}]
		')
	)
	rar? ( app-arch/unrar )
	samba? ( net-fs/samba[client] )
	sdl? (
		media-libs/libsdl2
		media-libs/freetype:2
		media-libs/harfbuzz
		media-libs/fontconfig
	)
	sftp? ( net-libs/libssh[sftp] )
	ssl? ( dev-libs/openssl:0= )
	webdav? ( net-libs/neon )
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER} )
	X? (
		x11-libs/libX11
		x11-libs/libXi
	)"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
	python? ( ${PYTHON_DEPS} )"

DOCS=( README.md )

pkg_setup() {
	if use wxwidgets; then
		setup-wxwidgets
	fi
	if use python; then
		python-single-r1_pkg_setup
	fi
}

src_prepare() {
	sed -e 's|\${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/|\\$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/|g' \
		-i CMakeLists.txt || die
	sed -e 's:cmake_minimum_required (VERSION 3\.5\.0):cmake_minimum_required (VERSION 3.10.0):' \
		-i CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DMULTIARC="$(usex archive)"
		-DNR_AWS="$(usex aws)"
		-DUSEUCD="$(usex chardet)"
		-DCOLORER="$(usex colorer)"
		-DMTP="$(usex mtp)"
		-DMTP_SYSTEM_LIBUSB=OFF
		-DMTP_SYSTEM_LIBMTP=OFF
		-DNR_NFS="$(usex nfs)"
		-DPYTHON="$(usex python)"
		-DUNRAR="$(usex rar lib NO)"
		-DNR_SMB="$(usex samba)"
		-DUSESDL="$(usex sdl)"
		-DNR_SFTP="$(usex sftp)"
		-DNR_OPENSSL="$(usex ssl)"
		-DNR_WEBDAV="$(usex webdav)"
		-DUSEWX="$(usex wxwidgets)"
		-DTTYX="$(usex X)"
		-DTTYXI="$(usex X)"

		-DMUSL="$(usex elibc_musl)"
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	optfeature "privileged file operations through far2l's sudo support" app-admin/sudo
}
