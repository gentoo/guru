# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

LLVM_COMPAT=( {18..21} )
RUST_MIN_VER="1.85.0"

inherit cargo llvm-r2 xdg

DESCRIPTION="Linux GPU Control Application"
HOMEPAGE="https://github.com/ilya-zlobintsev/LACT"
SRC_URI="
	https://github.com/ilya-zlobintsev/LACT/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+="
		https://github.com/pastalian/distfiles/releases/download/${P}/${P}-crates.tar.xz
	"
fi
S="${WORKDIR}/${P^^}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0
	CDLA-Permissive-2.0 ISC LGPL-3+ MIT MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui libadwaita test video_cards_nvidia"
REQUIRED_USE="libadwaita? ( gui ) test? ( gui )"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	x11-libs/libdrm[video_cards_amdgpu]
	gui? (
		dev-libs/glib:2
		gui-libs/gtk:4[introspection]
		media-libs/fontconfig
		media-libs/freetype
		media-libs/graphene
		x11-libs/cairo
		x11-libs/pango
	)
	libadwaita? ( >=gui-libs/libadwaita-1.4.0:1 )
"
RDEPEND="
	${COMMON_DEPEND}
	dev-util/clinfo
	dev-util/vulkan-tools
	sys-apps/hwdata
"
DEPEND="
	${COMMON_DEPEND}
	test? ( sys-fs/fuse:3 )
"
# libclang is required for bindgen
BDEPEND="
	virtual/pkgconfig
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')
"

QA_FLAGS_IGNORED="usr/bin/lact"

pkg_setup() {
	llvm-r2_pkg_setup
	rust_pkg_setup
}

src_configure() {
	local myfeatures=(
		$(usev gui lact-gui)
		$(usev libadwaita adw)
		$(usev video_cards_nvidia nvidia)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install --path lact
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install-resources
	newinitd res/lact-daemon-openrc lactd
}

src_test() {
	local skip=(
		# requires newer sys-apps/hwdata
		--skip tests::snapshot_everything
	)
	cargo_src_test --workspace -- "${skip[@]}"
}
