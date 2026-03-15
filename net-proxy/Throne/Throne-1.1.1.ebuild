# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop go-module xdg

DESCRIPTION="Qt based cross-platform GUI proxy configuration manager"
HOMEPAGE="https://github.com/throneproj/Throne"
SRC_URI="
	https://github.com/throneproj/Throne/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
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
	dev-libs/protobuf:=
	dev-libs/qhotkey
	dev-qt/qtbase:6[dbus,network,widgets]
	media-libs/quirc:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-go/protobuf-go
	dev-go/protoc-gen-go-grpc
	dev-qt/qttools:6[linguist]
"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.0-use-system-QHotkey.patch"
	"${FILESDIR}/${PN}-1.1.1-dont-treat-warnings-as-errors.patch"
	"${FILESDIR}/${PN}-1.1.1-store-the-database-in-AppConfigLocation-by-default.patch"
	"${FILESDIR}/${PN}-1.1.1-use-system-quirc.patch"
)

src_unpack() {
	# The vendor tarball is unpacked to `${S}/core/server`, but `go-module_src_unpack`
	# requires the `vendor` directory to be present at `${S}/vendor`
	mkdir -p "${S}/vendor" || die

	go-module_src_unpack
}

src_prepare() {
	rm -r 3rdparty/{QHotkey,quirc} || die

	cmake_src_prepare
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

	pushd gen || die
	protoc -I . --go_out=. --go-grpc_out=. libcore.proto
	popd || die

	VERSION_SINGBOX=$(go list -m -f '{{.Version}}' github.com/sagernet/sing-box)
	ego build \
		-trimpath -ldflags "-w -s -checklinkname=0 \
		-X 'github.com/sagernet/sing-box/constant.Version=${VERSION_SINGBOX}' \
		-X 'internal/godebug.defaultGODEBUG=multipathtcp=0'" \
		-tags "with_clash_api,with_gvisor,with_quic,with_wireguard,with_utls,with_dhcp,with_tailscale,badlinkname,tfogo_checklinkname0"
}

src_install() {
	exeinto /usr/lib/Throne
	doexe "${BUILD_DIR}/Throne"
	doexe core/server/ThroneCore

	dosym -r /usr/lib/Throne/Throne /usr/bin/Throne

	doicon -s 256 res/public/Throne.png
	domenu "${FILESDIR}/Throne.desktop"
}
