# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=" "

RATATUI_COMMIT='dde5e05eccfe5b7cb7712b4bdf76edd0c2cd1f25'
declare -A GIT_CRATES=(
	[ratatui-core]="https://github.com/yazi-rs/ratatui;${RATATUI_COMMIT};ratatui-%commit%/ratatui-core"
)

RUST_MIN_VER="1.95.0"

inherit cargo desktop optfeature shell-completion xdg

DESCRIPTION="Blazing fast terminal file manager written in Rust, based on async I/O"
HOMEPAGE="https://yazi-rs.github.io"
SRC_URI="https://github.com/sxyazi/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz
	${CARGO_CRATE_URIS}
"

# both the LICENSE file and LICENSE-ICONS are MIT
LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD Boost-1.0 BlueOak-1.0.0 CC0-1.0 CDLA-Permissive-2.0
	ISC MIT MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+cli"

DEPEND="
	dev-libs/oniguruma:=
"
# apply-crates-fixes start
DEPEND+="
	>=dev-libs/jemalloc-5.3.1:=
"
BDEPEND="
	virtual/pkgconfig
"
# apply-crates-fixes end

RDEPEND="
	${DEPEND}
	cli? ( dev-vcs/git )
"

DOCS=(
	"CHANGELOG.md"
	"README.md"
	yazi-config/preset/
)

QA_FLAGS_IGNORED="
	usr/bin/ya.*
"

src_prepare() {
	sed -i -r 's/strip\s+= true/strip = false/' Cargo.toml || die "Sed failed!"
	sed -i -E \
		"s|^ratatui-core\s=\s\{\sgit\s=.+|ratatui-core = \{ path = '${WORKDIR}/ratatui-${RATATUI_COMMIT}/ratatui-core' \}|" \
		Cargo.toml || die "Patching ratatui-core path failed"
	eapply_user
}

src_compile() {
	# apply-crates-fixes start
	# unvendoring for tikv-jemalloc-sys crate
	export JEMALLOC_OVERRIDE="${ESYSROOT}/usr/$(get_libdir)/libjemalloc.so"
	# https://github.com/tikv/jemallocator/issues/19
	export CARGO_FEATURE_UNPREFIXED_MALLOC_ON_SUPPORTED_PLATFORMS=1
	# apply-crates-fixes end

	# workaround for GCC 15 issues:
	# unvendor libonig from rust-onig. see bugs 943785, 945008
	export RUSTONIG_SYSTEM_LIBONIG=1
	# generate shell completions from the actual CLI definitions
	export YAZI_GEN_COMPLETIONS=true
	# silences vergen
	export YAZI_NO_GITCL=1

	local myargs=(
		--package yazi-fm
	)

	use cli && myargs+=( --package yazi-cli )

	cargo_src_compile "${myargs[@]}"
}

src_test() {
	export RUSTONIG_SYSTEM_LIBONIG=1
	cargo_src_test --workspace
}

src_install() {
	dobin "$(cargo_target_dir)/${PN}"
	use cli && dobin "$(cargo_target_dir)/ya"

	newbashcomp "${S}/yazi-boot/completions/${PN}.bash" "${PN}"
	dozshcomp "${S}/yazi-boot/completions/_${PN}"
	dofishcomp "${S}/yazi-boot/completions/${PN}.fish"

	if use cli; then
		newbashcomp "${S}/yazi-cli/completions/ya.bash" "ya"
		dozshcomp "${S}/yazi-cli/completions/_ya"
		dofishcomp "${S}/yazi-cli/completions/ya.fish"
	fi

	domenu "assets/${PN}.desktop"
	newicon assets/logo.png yazi.png
	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "Nerd Font icons" media-fonts/symbols-nerd-font
	optfeature "video thumbnails" media-video/ffmpeg
	optfeature "archive extraction and preview" app-arch/7zip
	optfeature "JSON preview" app-misc/jq
	optfeature "PDF preview" app-text/poppler
	optfeature "file searching" sys-apps/fd
	optfeature "file content searching" sys-apps/ripgrep
	optfeature "quick file subtree navigation" ">=app-shells/fzf-0.53.0"
	optfeature "historical directory navigation" "app-shells/zoxide >=app-shells/fzf-0.53.0"
	optfeature "Font, HEIC and JPEG XL preview" ">=media-gfx/imagemagick-7.1.1"

	optfeature_header "Install one of these for clipboard support:"
	optfeature "Wayland clipboard support" gui-apps/wl-clipboard
	optfeature "X11 clipboard support" x11-misc/xclip x11-misc/xsel
}
