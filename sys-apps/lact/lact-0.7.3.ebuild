# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -A GIT_CRATES=(
	[copes]='https://gitlab.com/corectrl/copes;1bc002a030345787f0e11e0317975a2e4f2a22ee;copes-%commit%'
	[nvml-wrapper-sys]='https://github.com/ilya-zlobintsev/nvml-wrapper;d245c3010c72466cfb572f5baf91c91f7294bb36;nvml-wrapper-%commit%/nvml-wrapper-sys'
	[nvml-wrapper]='https://github.com/ilya-zlobintsev/nvml-wrapper;d245c3010c72466cfb572f5baf91c91f7294bb36;nvml-wrapper-%commit%/nvml-wrapper'
)

LLVM_COMPAT=( {18..19} )
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
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 GPL-3 GPL-3+
	ISC MIT Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui libadwaita test"
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
