# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools desktop qmake-utils xdg cmake

DESCRIPTION="The official Qt-based program for syncing your MEGA account in your PC"
HOMEPAGE="
	https://mega.io
	https://github.com/meganz/MEGAsync
"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/meganz/MEGAsync"
else
	MEGA_SDK_REV="37b346c2e119559e40c08f43e1a8f54353e7ad59" # commit of src/MEGASync/mega submodule
	SRC_URI="
		https://github.com/meganz/MEGAsync/archive/v${PV}_Win.tar.gz -> ${P}.tar.gz
		https://github.com/meganz/sdk/archive/${MEGA_SDK_REV}.tar.gz -> ${PN}-sdk-${PV}.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
	# 4.3.8.0 has no dedicated linux tag
	S="${WORKDIR}"/MEGAsync-${PV}_Win
fi

LICENSE="MEGA"
SLOT="0"
IUSE="+cryptopp +curl +sqlite +zlib dolphin examples freeimage java nautilus php python readline threads thunar"

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
	nautilus? ( >=gnome-base/nautilus-3 )
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
"

DOCS=( CREDITS.md README.md )

CMAKE_USE_DIR="${S}/src/MEGAShellExtDolphin"

src_prepare() {
	if [[ ${PV} != 9999 ]]; then
		rmdir src/MEGASync/mega
		mv "${WORKDIR}"/sdk-${MEGA_SDK_REV} src/MEGASync/mega
	fi
	if use dolphin; then
		# use the kde5 CMakeLists instead of the kde 4 version
		mv src/MEGAShellExtDolphin/CMakeLists_kde5.txt src/MEGAShellExtDolphin/CMakeLists.txt || die
		cmake_src_prepare
	else
		default
	fi
	cd src/MEGASync/mega
	eautoreconf
}

src_configure() {
	cd src/MEGASync/mega
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
		"--enable-chat" \
		"--enable-gcc-hardening"
	cd ../..

	local myeqmakeargs=(
		MEGA.pro
		CONFIG+="release"
	)

	eqmake5 ${myeqmakeargs[@]}
	use dolphin && cmake_src_configure
	$(qt5_get_bindir)/lrelease MEGASync/MEGASync.pro
}

src_compile() {
	emake -C src INSTALL_ROOT="${D}" || die
	use dolphin && cmake_src_compile
}

src_install() {
	use dolphin && cmake_src_install
	einstalldocs
	dobin src/MEGASync/${PN}
	insinto usr/share/licenses/${PN}
	doins LICENCE.md installer/terms.txt
	domenu src/MEGASync/platform/linux/data/${PN}.desktop
	cd src/MEGASync/platform/linux/data/icons/hicolor
	for size in 16x16 32x32 48x48 128x128 256x256;do
		doicon -s $size $size/apps/mega.png
	done
}
