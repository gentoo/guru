# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop

DESCRIPTION="Alternative Discord client using GTK instead of Electron"
HOMEPAGE="https://github.com/uowuo/abaddon"
SRC_URI="
	https://github.com/uowuo/abaddon/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-cpp/simpleini-4.17_p20210901
	dev-cpp/gtkmm:3.0=
	dev-db/sqlite:3
	net-misc/curl
	>=net-libs/ixwebsocket-11.2.8
	sys-libs/zlib:=
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-remove-vendored-dependencies.patch"
)

src_install() {
	dodoc README.md

	dobin "${BUILD_DIR}"/abaddon

	insinto /usr/share/${PN}
	doins -r css res

	make_desktop_entry /usr/bin/${PN}
}
