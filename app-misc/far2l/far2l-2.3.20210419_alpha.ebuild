# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_BUILD_TYPE="Release"
WX_GTK_VER="3.0-gtk3"

inherit eutils cmake xdg-utils wxwidgets python-any-r1

DESCRIPTION="Linux port of Far Manager"
HOMEPAGE="https://github.com/elfmz/far2l"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/elfmz/far2l"
	EGIT_BRANCH="master"
else
	MY_PV="${PV:4:4}-${PV:8:2}-${PV:10:8}"
	MY_P="${PN}-${MY_PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/elfmz/far2l/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+ssl libressl sftp samba nfs webdav +archive +wxwidgets python +static-libs"

BDEPEND=">=dev-util/cmake-3.2.2
	sys-devel/m4"

RDEPEND="sys-apps/gawk
	dev-libs/xerces-c
	dev-libs/spdlog
	app-i18n/uchardet
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER} )
	ssl? (
		!libressl? ( dev-libs/openssl )
		libressl? ( dev-libs/libressl )
	)
	sftp? ( net-libs/libssh[sftp] )
	samba? ( net-fs/samba )
	nfs? ( net-fs/libnfs )
	webdav? ( net-libs/neon )
	archive? (
		dev-libs/libpcre2
		app-arch/libarchive )
	python? ( $(python_gen_any_dep 'dev-python/virtualenv[${PYTHON_USEDEP}]') )"

DEPEND="${RDEPEND}"

pkg_setup() {
	if use wxwidgets; then
		setup-wxwidgets
	fi
}

src_prepare() {
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_askpass)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_sudoapp)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/objinfo/plug/objinfo.far-plug-mb)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/farftp/plug/farftp.far-plug-mb && echo Removed existing farftp plugin)::" -i "${S}"/CMakeLists.txt
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/python/plug/python.far-plug-wide && echo Removed existing python plugin)::" -i "${S}"/CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSEWX="$(usex wxwidgets)"
		-DPYTHON="$(usex python)"
		-DBUILD_SHARED_LIBS="$(usex static-libs "no" "yes")"
	)

	cmake_src_configure
}

src_install(){
	cmake_src_install
	einstalldocs
	dosym "../../bin/far2l" "usr/lib/far2l/far2l_askpass"
	dosym "../../bin/far2l" "usr/lib/far2l/far2l_sudoapp"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}