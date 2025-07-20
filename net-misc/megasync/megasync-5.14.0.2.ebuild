# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic qmake-utils xdg

DESCRIPTION="The official Qt-based program for syncing your MEGA account in your PC"
HOMEPAGE="
	https://mega.io
	https://github.com/meganz/MEGAsync
"

MEGA_SDK_REV="9d816439574996306468895bc784568707bd1b88" # commit of src/MEGASync/mega submodule
MEGA_TAG_SUFFIX="Linux"
SRC_URI="
	https://github.com/meganz/MEGAsync/archive/v${PV}_${MEGA_TAG_SUFFIX}.tar.gz -> ${P}.tar.gz
	https://github.com/meganz/sdk/archive/${MEGA_SDK_REV}.tar.gz -> ${PN}-sdk-${PV}.tar.gz
"
S="${WORKDIR}"/MEGAsync-${PV}_${MEGA_TAG_SUFFIX}

LICENSE="MEGA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dolphin mediainfo nautilus nemo thumbnail thunar"

DEPEND="
	dev-db/sqlite:3
	dev-libs/crypto++:=
	dev-libs/icu:=
	dev-libs/libsodium:=
	dev-libs/libuv:=
	dev-libs/openssl:0=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtimageformats:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	net-misc/curl[ssl]
	sys-libs/zlib
	x11-libs/libxcb:=
	dolphin? (
		dev-qt/qtbase:6[network,widgets]
		kde-apps/dolphin:6
		kde-frameworks/kcoreaddons:6
		kde-frameworks/kio:6
		kde-frameworks/kwidgetsaddons:6
	)
	mediainfo? (
		media-libs/libmediainfo
		media-libs/libzen
	)
	nautilus? (
		dev-libs/glib:2
		>=gnome-base/nautilus-43
	)
	nemo? (
		dev-libs/glib:2
		gnome-extra/nemo
	)
	thumbnail? (
		media-libs/freeimage
		media-video/ffmpeg:=
	)
	thunar? (
		dev-libs/glib:2
		xfce-base/thunar:=
	)
"
RDEPEND="
	${DEPEND}
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
"
BDEPEND="
	dev-qt/linguist-tools:5
	virtual/pkgconfig
	dolphin? ( kde-frameworks/extra-cmake-modules )
"

PATCHES=(
	"${FILESDIR}/${PN}-5.6.0.0-remove-clang-format.patch"
	"${FILESDIR}/${PN}-5.7.0.0-disable-forced-options.patch"
	"${FILESDIR}/${PN}-5.7.0.0-fix-install-dir.patch"
	"${FILESDIR}/${PN}-5.7.0.0-rename-libcryptopp.patch"
	"${FILESDIR}/${PN}-5.10.0.2-link-zlib.patch"
)

BUILD_DIR_DOLPHIN="${S}_dolphin"

dolphin_run() {
	if use dolphin; then
		cd "${S}/src/MEGAShellExtDolphin" || die
		BUILD_DIR="${BUILD_DIR_DOLPHIN}" CMAKE_USE_DIR="${S}/src/MEGAShellExtDolphin" "$@"
	fi
}

nemo_run() {
	if use nemo; then
		cd "${S}/src/MEGAShellExtNemo" || die
		"$@"
	fi
}

thunar_run() {
	if use thunar; then
		cd "${S}/src/MEGAShellExtThunar" || die
		"$@"
	fi
}

src_prepare() {
	rmdir src/MEGASync/mega || die
	mv "${WORKDIR}/sdk-${MEGA_SDK_REV}" src/MEGASync/mega || die

	cmake_src_prepare
}

src_configure() {
	# https://github.com/meganz/sdk/issues/2679
	append-cppflags -DNDEBUG

	local mycmakeargs=(
		# build internal libs as static
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_MODULE_PATH="${S}/src/MEGASync/mega/cmake/modules/packages"
		-DENABLE_DESKTOP_APP_TESTS=OFF
		-DENABLE_DESKTOP_APP_WERROR=OFF
		-DENABLE_DESKTOP_UPDATE_GEN=OFF
		-DENABLE_DESIGN_TOKENS_IMPORTER=OFF
		-DUSE_BREAKPAD=OFF
		-DENABLE_ISOLATED_GFX=$(usex thumbnail)
		-DENABLE_LINUX_EXT=$(usex nautilus)
		-DUSE_FFMPEG=$(usex thumbnail)
		-DUSE_FREEIMAGE=$(usex thumbnail)
		-DUSE_MEDIAINFO=$(usex mediainfo)
		-DUSE_PDFIUM=OFF
		-DUSE_READLINE=OFF
	)
	cmake_src_configure

	mycmakeargs=(
		-DKF_VER=6
		-DQt_VER=6
	)
	dolphin_run cmake_src_configure
	nemo_run eqmake5 DEFINES=no_desktop
	thunar_run eqmake5
}

src_compile() {
	cmake_src_compile

	dolphin_run cmake_src_compile
	nemo_run emake
	thunar_run emake
}

src_install() {
	cmake_src_install

	dolphin_run cmake_src_install
	nemo_run emake INSTALL_ROOT="${D}" install
	thunar_run emake INSTALL_ROOT="${D}" install
}
