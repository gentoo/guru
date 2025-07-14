# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -A GIT_CRATES=(
	[cl3]='https://github.com/kenba/cl3;cb019aac330ab8243804be02b7183a1c5a211caa;cl3-%commit%'
	[libdrm_amdgpu_sys]='https://github.com/Umio-Yasuno/libdrm-amdgpu-sys-rs;c6d85fce871f79f763162ba15accdfcae74b2d40;libdrm-amdgpu-sys-rs-%commit%'
)

LLVM_COMPAT=( {18..20} )
RUST_MIN_VER="1.76.0"

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
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 GPL-3 ISC MIT
	MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui libadwaita test video_cards_nvidia"
REQUIRED_USE="libadwaita? ( gui ) test? ( gui )"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	virtual/opencl
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
	sed -i "/^strip =/d" Cargo.toml || die
	sed -i "s|target/release|$(cargo_target_dir)|" Makefile || die

	local myfeatures=(
		$(usev gui lact-gui)
		$(usev libadwaita adw)
		$(usev video_cards_nvidia nvidia)
	)
	cargo_src_configure --no-default-features -p lact
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	newinitd res/lact-daemon-openrc lactd
}

src_test() {
	local skip=(
		# requires newer sys-apps/hwdata
		--skip tests::snapshot_everything
	)
	cargo_src_test --workspace -- "${skip[@]}"
}
