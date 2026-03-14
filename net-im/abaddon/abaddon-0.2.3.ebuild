# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

DESCRIPTION="Alternative Discord client using GTK instead of Electron"
HOMEPAGE="https://github.com/uowuo/abaddon"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uowuo/abaddon.git"
	EGIT_SUBMODULES=() # all dependencies are provided by portage
else
	SRC_URI="https://github.com/uowuo/abaddon/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+voice +rnnoise"

REQUIRED_USE="rnnoise? ( voice )"

RDEPEND="
	dev-cpp/atkmm
	dev-cpp/cairomm
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:3.0
	dev-cpp/pangomm:1.4
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libfmt:=
	dev-libs/libsigc++:2
	dev-libs/libsodium:=
	dev-libs/spdlog:=
	media-libs/opus
	>=net-libs/ixwebsocket-11.0.8:=
	net-misc/curl
	virtual/zlib:=
	x11-libs/gtk+:3
	gui-libs/libhandy:1
	rnnoise? ( media-libs/rnnoise )
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
	dev-libs/miniaudio
"
BDEPEND="
	voice? ( virtual/pkgconfig )
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_VOICE=$(usex voice)
		-DENABLE_RNNOISE=$(usex rnnoise)
		-DUSE_KEYCHAIN=no # no package for it in ::guru or ::gentoo
		-DENABLE_QRCODE_LOGIN=no # expects vendored qrcodegen
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	domenu res/desktop/io.github.uowuo.${PN}.desktop

	newicon -s scalable res/desktop/icon.svg io.github.uowuo.${PN}.svg

	insinto /usr/share/metainfo
	doins res/desktop/io.github.uowuo.${PN}.metainfo.xml
}
