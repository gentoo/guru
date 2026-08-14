# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.92.0"

inherit cargo desktop xdg

DESCRIPTION="A hardware-accelerated GPU terminal emulator powered by WebGPU"
HOMEPAGE="https://rioterm.com"
SRC_URI="https://github.com/raphamorim/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
DEPS_URI="https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0
	Unicode-DFS-2016 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+wayland +X"
REQUIRED_USE="|| ( wayland X )"

DEPEND="
	media-libs/freetype:2
	media-libs/fontconfig
	wayland? ( dev-libs/wayland )
	wayland? ( x11-libs/libxkbcommon[wayland] )
	X? ( x11-libs/libxkbcommon[X] )
	>=sys-libs/ncurses-6.4_p20240330
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
	dev-build/cmake
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="usr/bin/rio"

DOCS=(
	"README.md"
)

src_prepare() {
	default
	sed -i '/^strip =/d' Cargo.toml || die
}

src_configure() {
	local myfeatures=(
		$(usev wayland)
		$(usev X x11)
	)
	cargo_src_configure --verbose --no-default-features
}

src_compile() {
	cargo_src_compile
	scdoc < extra/man/rio.1.scd > extra/man/rio.1
	scdoc < extra/man/rio.5.scd > extra/man/rio.5
	scdoc < extra/man/rio-bindings.5.scd > extra/man/rio-bindings.5
}

src_install() {
	dobin "$(cargo_target_dir)/${PN}"

	doman extra/man/rio.1
	doman extra/man/rio.5
	doman extra/man/rio-bindings.5
	dodoc -r "${DOCS[@]}"
	newicon -s scalable "misc/logo.svg" "${PN}.svg"
	domenu "misc/${PN}.desktop"
}
