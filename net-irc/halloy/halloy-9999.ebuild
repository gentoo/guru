# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.92.0"

inherit cargo desktop xdg

DESCRIPTION="IRC application written in Rust"
HOMEPAGE="https://github.com/squidowl/halloy"
LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 ISC MIT MPL-2.0 UoI-NCSA Unicode-3.0 Unlicense ZLIB
"
SLOT="0"

IUSE="opengl +vulkan wayland +X"
REQUIRED_USE="
	|| ( opengl vulkan )
	vulkan? ( || ( wayland X ) )
"

if [[ ${PV} = *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/squidowl/halloy"
else
	KEYWORDS="~amd64"
	SRC_URI="
		https://github.com/squidowl/halloy/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
fi

# https://github.com/iced-rs/iced/blob/master/DEPENDENCIES.md
BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	dev-libs/expat
	dev-libs/openssl
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype[X?]
	opengl? ( media-libs/libglvnd[X?] )
	vulkan? ( media-libs/vulkan-loader[wayland?,X?] )
	wayland? ( dev-libs/wayland	)
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXrandr
	)
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_unpack() {
	if [[ ${PV} = *9999* ]] ; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	if [[ ${PV} != *9999* ]] ; then
		# Fix cargo.eclass handling of patched dependencies
		# https://github.com/squidowl/halloy/blob/2025.12/Cargo.toml#L114-L116
		sed -i "s,'https://github.com/squidowl/iced',crates-io,g" \
			"${ECARGO_HOME}/config.toml" || die
	fi
	cargo_src_configure
}

src_compile() {
	export OPENSSL_NO_VENDOR=1
	export PKG_CONFIG_ALLOW_CROSS=1
	cargo_src_compile
}

src_install() {
	local size
	for size in 24 32 48 64 96 128 256 512; do
		doicon --size ${size} assets/linux/icons/hicolor/${size}x${size}/apps/org.squidowl.${PN}.png
	done

	domenu assets/linux/org.squidowl.${PN}.desktop

	cargo_src_install
}
