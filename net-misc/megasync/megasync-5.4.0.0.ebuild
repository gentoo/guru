# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic qmake-utils xdg

DESCRIPTION="The official Qt-based program for syncing your MEGA account in your PC"
HOMEPAGE="
	https://mega.io
	https://github.com/meganz/MEGAsync
"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/meganz/MEGAsync"
	EGIT_BRANCH="master"
	EGIT_SUBMODULES=( '*' )
else
	MEGA_SDK_REV="8ffa53c73b8295415f965139daf78cecbac70482" # commit of src/MEGASync/mega submodule
	MEGA_TAG_SUFFIX="Linux"
	SRC_URI="
		https://github.com/meganz/MEGAsync/archive/v${PV}_${MEGA_TAG_SUFFIX}.tar.gz -> ${P}.tar.gz
		https://github.com/meganz/sdk/archive/${MEGA_SDK_REV}.tar.gz -> ${PN}-sdk-${PV}.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/MEGAsync-${PV}_${MEGA_TAG_SUFFIX}
fi

LICENSE="MEGA"
SLOT="0"
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
	net-dns/c-ares:=
	net-misc/curl[ssl]
	sys-libs/zlib
	x11-libs/libxcb:=
	dolphin? (
		kde-apps/dolphin:5
		kde-frameworks/kcoreaddons:5
		kde-frameworks/kio:5
		kde-frameworks/kwidgetsaddons:5
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
	thunar? ( xfce-base/thunar:= )
"
RDEPEND="
	${DEPEND}
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
"
BDEPEND="
	dev-qt/linguist-tools:5
	dolphin? ( kde-frameworks/extra-cmake-modules )
"

PATCHES=(
	"${FILESDIR}/${PN}-4.10.0.0_ffmpeg6.patch"
	"${FILESDIR}/${PN}-4.10.0.0_fix-build.patch"
	"${FILESDIR}/${PN}-5.3.0.0-link-zlib.patch"
	"${FILESDIR}/${PN}-5.3.0.0-fix-install-dir.patch"
	"${FILESDIR}/${PN}-5.3.0.0-rename-libcryptopp.patch"
)

BUILD_DIR_DOLPHIN="${S}_dolphin"

dolphin_run() {
	if use dolphin; then
		cd "${S}/src/MEGAShellExtDolphin" || die
		BUILD_DIR="${BUILD_DIR_DOLPHIN}" CMAKE_USE_DIR="${S}/src/MEGAShellExtDolphin" "$@"
	fi
}

nautilus_run() {
	if use nautilus; then
		cd "${S}/src/MEGAShellExtNautilus" || die
		"$@"
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
	if [[ ${PV} != 9999 ]]; then
		rmdir src/MEGASync/mega || die
		mv "${WORKDIR}/sdk-${MEGA_SDK_REV}" src/MEGASync/mega || die
	fi

	cmake_src_prepare
}

src_configure() {
	# https://github.com/meganz/sdk/issues/2679
	append-cppflags -DNDEBUG

	local mycmakeargs=(
		# build internal libs as static
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_MODULE_PATH="${S}/src/MEGASync/mega/contrib/cmake/modules/packages"
		-DENABLE_DESKTOP_UPDATE_GEN=OFF
		-DUSE_FFMPEG=$(usex thumbnail)
		-DUSE_FREEIMAGE=$(usex thumbnail)
		-DUSE_MEDIAINFO=$(usex mediainfo)
		-DUSE_PDFIUM=OFF
		-DUSE_READLINE=OFF
	)
	cmake_src_configure

	unset mycmakeargs
	dolphin_run cmake_src_configure
	nautilus_run eqmake5
	nemo_run eqmake5
	thunar_run eqmake5
}

src_compile() {
	cmake_src_compile

	dolphin_run cmake_src_compile
	nautilus_run emake
	nemo_run emake
	thunar_run emake
}

src_install() {
	cmake_src_install

	dolphin_run cmake_src_install
	nautilus_run emake INSTALL_ROOT="${D}" install
	nemo_run emake INSTALL_ROOT="${D}" install
	thunar_run emake INSTALL_ROOT="${D}" install
}
