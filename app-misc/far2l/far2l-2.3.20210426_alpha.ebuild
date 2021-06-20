# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

WX_GTK_VER="3.0-gtk3"

inherit cmake xdg wxwidgets python-r1

DESCRIPTION="Linux port of FAR Manager v2"
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
IUSE="+ssl sftp samba nfs webdav +archive +wxwidgets python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

BDEPEND="sys-devel/m4"

RDEPEND="dev-libs/xerces-c
	dev-libs/spdlog
	app-i18n/uchardet
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER} )
	ssl? ( dev-libs/openssl )
	sftp? ( net-libs/libssh[sftp] )
	samba? ( net-fs/samba )
	nfs? ( net-fs/libnfs )
	webdav? ( net-libs/neon )
	archive? (
		dev-libs/libpcre2
		app-arch/libarchive )
	python? (
		${PYTHON_DEPS}
		virtual/python-cffi
		dev-python/debugpy
		$(python_gen_any_dep 'dev-python/virtualenv[${PYTHON_USEDEP}]')
	)"

DEPEND="${RDEPEND}"

DOCS=( README.md )

pkg_setup() {
	if use wxwidgets; then
		setup-wxwidgets
	fi
}

src_prepare() {
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_askpass)::" -i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND ln -sf \../../bin/far2l \${CMAKE_INSTALL_PREFIX}/lib/far2l/far2l_sudoapp)::" -i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/objinfo/plug/objinfo.far-plug-mb)::" -i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/farftp/plug/farftp.far-plug-mb && echo Removed existing farftp plugin)::" -i "${S}"/CMakeLists.txt || die
	sed -e "s:execute_process(COMMAND rm -f \${CMAKE_INSTALL_PREFIX}/lib/far2l/Plugins/python/plug/python.far-plug-wide && echo Removed existing python plugin)::" -i "${S}"/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSEWX="$(usex wxwidgets)"
		-DPYTHON="$(usex python)"
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
