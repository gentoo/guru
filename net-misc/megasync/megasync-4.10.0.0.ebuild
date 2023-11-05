# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools cmake qmake-utils xdg

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
	MEGA_SDK_REV="91d14ae6b024339dd4e15acb367ac20fb24633ac" # commit of src/MEGASync/mega submodule
	MEGA_TAG_SUFFIX="Win"
	SRC_URI="
		https://github.com/meganz/MEGAsync/archive/v${PV}_${MEGA_TAG_SUFFIX}.tar.gz -> ${P}.tar.gz
		https://github.com/meganz/sdk/archive/${MEGA_SDK_REV}.tar.gz -> ${PN}-sdk-${PV}.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/MEGAsync-${PV}_${MEGA_TAG_SUFFIX}
fi

LICENSE="MEGA"
SLOT="0"
IUSE="+cryptopp +curl +sqlite +zlib dolphin examples freeimage java nautilus nemo php python readline threads thunar"

RDEPEND="
	app-arch/xz-utils
	dev-libs/libgcrypt
	dev-libs/libsodium
	dev-libs/libuv
	dev-libs/openssl:0=
	media-libs/libpng
	net-dns/c-ares
	x11-themes/hicolor-icon-theme
	cryptopp? ( dev-libs/crypto++ )
	curl? ( net-misc/curl[ssl,curl_ssl_openssl(-)] )
	dolphin? ( kde-apps/dolphin )
	freeimage? ( media-libs/freeimage )
	nautilus? ( >=gnome-base/nautilus-43 )
	nemo? ( gnome-extra/nemo )
	readline? ( sys-libs/readline:0 )
	sqlite? ( dev-db/sqlite:3 )
	thunar? ( xfce-base/thunar )
	zlib? ( sys-libs/zlib )
"
DEPEND="
	${RDEPEND}
	media-libs/libmediainfo
	media-libs/libraw
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtdbus:5
	dev-qt/qtimageformats:5
	dev-qt/qtsvg:5
	dev-qt/qtx11extras:5
"
BDEPEND="
	dev-lang/swig
	dev-qt/linguist-tools
	dolphin? ( kde-frameworks/extra-cmake-modules )
"

CMAKE_USE_DIR="${S}/src/MEGAShellExtDolphin"

src_prepare() {
	if [[ ${PV} != 9999 ]]; then
		rmdir src/MEGASync/mega
		mv "${WORKDIR}/sdk-${MEGA_SDK_REV}" src/MEGASync/mega
	fi

	if has_version ">=media-video/ffmpeg-6.0"; then
		eapply "${FILESDIR}/${PN}-4.10.0.0_ffmpeg6.patch"
	fi
	eapply "${FILESDIR}/${PN}-4.10.0.0_fix-build.patch"

	if use dolphin; then
		cmake_src_prepare
	else
		default
	fi

	cd "${S}/src/MEGASync/mega"
	eautoreconf
}

src_configure() {
	cd "${S}/src/MEGASync/mega"
	econf \
		"--disable-silent-rules" \
		"--disable-curl-checks" \
		"--disable-megaapi" \
		$(use_with zlib) \
		$(use_with sqlite) \
		$(use_with cryptopp) \
		"--with-cares" \
		$(use_with curl) \
		"--without-termcap" \
		$(use_enable threads posix-threads) \
		"--with-sodium" \
		$(use_with freeimage) \
		$(use_with readline) \
		$(use_enable examples) \
		$(use_enable java) \
		$(use_enable php) \
		$(use_enable python) \
		"--enable-gcc-hardening"

	cd "${S}/src"
	local myeqmakeargs=(
		MEGA.pro
		CONFIG+="release"
		$(usex freeimage "" "CONFIG+=nofreeimage")
		$(usev nautilus "SUBDIRS+=MEGAShellExtNautilus")
		$(usev nemo "SUBDIRS+=MEGAShellExtNemo")
		$(usev thunar "SUBDIRS+=MEGAShellExtThunar")
	)

	eqmake5 ${myeqmakeargs[@]}
	$(qt5_get_bindir)/lrelease MEGASync/MEGASync.pro

	use dolphin && cmake_src_configure
}

src_compile() {
	emake -C src

	use dolphin && cmake_src_compile
}

src_install() {
	emake -C src INSTALL_ROOT="${D}" install
	dobin "src/MEGASync/${PN}"
	dodoc CREDITS.md README.md

	rm -rf "${D}"/usr/share/doc/megasync
	rm -rf "${D}"/usr/share/icons/ubuntu-mono-dark

	use dolphin && cmake_src_install
}
