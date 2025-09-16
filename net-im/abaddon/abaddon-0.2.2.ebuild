# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="Alternative Discord client using GTK instead of Electron"
HOMEPAGE="https://github.com/uowuo/abaddon"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/uowuo/abaddon.git"
	# All dependencies are provided by portage
	EGIT_SUBMODULES=()
	inherit git-r3
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/uowuo/abaddon/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+libhandy +rnnoise qrcodegen"

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
	sys-libs/zlib:=
	x11-libs/gtk+:3
	libhandy? ( gui-libs/libhandy:1 )
	qrcodegen? ( dev-libs/qr-code-generator )
	rnnoise? ( media-libs/rnnoise )
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
	dev-libs/miniaudio
"

src_configure() {
	# Disable keychain because there's currently
	# no package for it in ::guru or ::gentoo
	local mycmakeargs=(
		-DUSE_LIBHANDY="$(usex libhandy)"
		-DENABLE_RNNOISE="$(usex rnnoise)"
		-DUSE_KEYCHAIN="no"
		-DENABLE_QRCODE_LOGIN="$(usex qrcodegen)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	make_desktop_entry /usr/bin/${PN}
}
