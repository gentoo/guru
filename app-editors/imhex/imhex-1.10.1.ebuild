# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_BUILD_TYPE="Release"
CMAKE_MAKEFILE_GENERATOR="emake"
LLVM_MAX_SLOT=12
PYTHON_COMPAT=( python3_{8..10} )

inherit cmake desktop llvm python-single-r1 xdg-utils

DESCRIPTION="A hex editor for reverse engineers, programmers, and eyesight"
HOMEPAGE="https://github.com/WerWolv/ImHex"
SRC_URI="https://github.com/WerWolv/ImHex/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ImHex-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	${PYTHON_DEPS}
	app-forensics/yara
	>=dev-cpp/nlohmann_json-3.10.2
	dev-cpp/xdgpp
	dev-libs/capstone
	>=dev-libs/libfmt-8.0.0
	dev-libs/nativefiledialog-extended
	dev-libs/openssl
	dev-libs/tre
	media-libs/freetype
	media-libs/glfw
	media-libs/glm
	net-libs/mbedtls
	net-misc/curl
	sys-apps/file
	sys-devel/llvm:${LLVM_MAX_SLOT}
	virtual/libiconv
	virtual/libintl
"
RDEPEND="${DEPEND}"
BDEPEND="app-admin/chrpath"

PATCHES=(
	"${FILESDIR}/${P}-no-lLLVMDemangle.patch"
	"${FILESDIR}/${PN}-1.8.1-system-xdgpp.patch"
	"${FILESDIR}/${P}-system-nativefiledialog.patch"
)
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	rm -r external/{curl,fmt,llvm,nativefiledialog,nlohmann_json,xdgpp,yara} || die
	cmake_src_prepare
}

src_configure() {
	python-single-r1_pkg_setup
	local mycmakeargs=(
		-DPROJECT_VERSION="${PV}"
		-DPYTHON_VERSION_MAJOR_MINOR="\"${EPYTHON/python/}\""
		-DUSE_SYSTEM_CURL=ON
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_LLVM=ON
		-DUSE_SYSTEM_NLOHMANN_JSON=ON
		-DUSE_SYSTEM_YARA=ON
	)
	cmake_src_configure
}

src_install() {
	# can't use cmake_src_install, doing it manual
	dobin "${BUILD_DIR}/${PN}"
	insinto "/usr/$(get_libdir)"
	doins "${BUILD_DIR}/plugins/builtin/builtin.hexplug"
	dolib.so "${BUILD_DIR}/plugins/lib${PN}/lib${PN}.so"
	insinto "/usr/share/${PN}"
	doins "${S}/res/icon.ico"
	doins -r "${S}/res/resources"

	chrpath -d "${ED}/usr/bin/imhex"
	chrpath -d "${ED}/usr/$(get_libdir)/builtin.hexplug"

	mypythondir="${D}/$(python_get_sitedir)/imhex"
	mkdir -p "${mypythondir}" || die
	mv "${S}"/python_libs/lib/* "${mypythondir}" || die
	python_optimize "${mypythondir}"

	# create desktop icon
	make_desktop_entry "imhex" "ImHex" "/usr/share/${PN}/icon.ico" "X-Editor"

	# install docs
	einstalldocs
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
