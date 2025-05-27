# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop go-module xdg

DESCRIPTION="Qt based cross-platform GUI proxy configuration manager"
HOMEPAGE="https://github.com/Mahdi-zarei/nekoray"
SRC_URI="
	https://github.com/Mahdi-zarei/nekoray/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

# The first line is for the C++ code, the second line is for the Go module
LICENSE="
	GPL-3+ MIT
	0BSD Apache-2.0 BSD ISC MIT MPL-2.0 Unlicense
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-cpp/abseil-cpp:=
	dev-cpp/yaml-cpp
	dev-libs/protobuf:=
	dev-libs/qhotkey
	dev-qt/qtbase:6[dbus,network,widgets]
	media-libs/zxing-cpp
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qttools:6[linguist]
"

PATCHES=(
	"${FILESDIR}"/${PN}-4.3.5-use-system-qhotkey.patch
)

src_unpack() {
	# The vendor tarball is unpacked to `${S}/core/server`, but `go-module_src_unpack`
	# requires the `vendor` directory to be present at `${S}/vendor`
	mkdir -p "${S}/vendor" || die

	go-module_src_unpack
}

src_configure() {
	local mycmakeargs=(
		-DNKR_PACKAGE=true
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	cd "${S}/core/server" || die

	VERSION_SINGBOX=$(go list -m -f '{{.Version}}' github.com/sagernet/sing-box)
	ego build \
		-trimpath -ldflags "-w -s -X 'github.com/sagernet/sing-box/constant.Version=${VERSION_SINGBOX}'" \
		-tags "with_clash_api,with_gvisor,with_quic,with_wireguard,with_utls,with_ech,with_dhcp"
}

src_install() {
	exeinto /usr/lib/nekoray
	doexe "${BUILD_DIR}/nekoray"
	doexe core/server/nekobox_core

	dosym -r /usr/lib/nekoray/nekoray /usr/bin/nekoray

	doicon -s 256 res/public/nekobox.png
	domenu "${FILESDIR}/nekoray.desktop"
}
