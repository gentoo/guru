# Copyright 2021-2023 Gentoo Authors
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
	dev-cpp/gtkmm:3.0=
	dev-db/sqlite:3
	dev-libs/miniaudio
	media-libs/opus
	dev-libs/spdlog
	>=net-libs/ixwebsocket-11.0.8
	net-misc/curl
	sys-libs/zlib:=
	libhandy? ( gui-libs/libhandy:= )
	qrcodegen? ( dev-libs/qrcodegen )
	rnnoise? ( media-libs/rnnoise )
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
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
	dobin "${BUILD_DIR}"/abaddon

	insinto /usr/share/${PN}
	doins -r res/*

	make_desktop_entry /usr/bin/${PN}
}
