# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -A GIT_CRATES=(
	[ratatui-core]="https://github.com/yazi-rs/ratatui;dde5e05eccfe5b7cb7712b4bdf76edd0c2cd1f25;ratatui-%commit%/ratatui-core"
)

RUST_MIN_VER="1.95.0"

inherit cargo desktop optfeature shell-completion xdg

DESCRIPTION="Blazing fast terminal file manager written in Rust, based on async I/O"
HOMEPAGE="https://yazi-rs.github.io"
SRC_URI="
	https://github.com/sxyazi/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD Boost-1.0 BlueOak-1.0.0 CC0-1.0 CDLA-Permissive-2.0
	ISC MIT MPL-2.0 Unicode-3.0 ZLIB
"

SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+cli test"
RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pkgconfig
"

DEPEND="
	dev-libs/oniguruma:=
"

RDEPEND="
	${DEPEND}
	sys-apps/file
	cli? ( dev-vcs/git )
"

DOCS=(
	CHANGELOG.md
	README.md
	LICENSE
	LICENSE-ICONS
)

src_unpack() {
	cargo_src_unpack

	local crate="ratatui-core"
	local crate_uri commit crate_dir host

	IFS=';' read -r crate_uri commit crate_dir host \
		<<< "${GIT_CRATES["${crate}"]}"
	: "${crate_dir:=${crate}-%commit%}"

	printf -- \
		'[patch.crates-io]\n%s = { path = "%s" }\n' \
		"${crate}" \
		"${WORKDIR}/${crate_dir//%commit%/${commit}}" \
		>> "${CARGO_HOME}/config.toml" || die
}

src_prepare() {
	default

	cargo_env "${CARGO}" update \
		--offline \
		-p ratatui-core || die "failed to update ratatui-core lock entry"

	sed -i -E \
		's/^strip[[:space:]]*=[[:space:]]*true/strip = false/' \
		Cargo.toml || die
}

src_configure() {
	cargo_src_configure --frozen
}

src_compile() {
	# workaround for GCC 15 issues:
	# unvendor libonig from rust-onig. see bugs 943785, 945008
	export RUSTONIG_SYSTEM_LIBONIG=1

	# generate shell completions from the actual CLI definitions
	export YAZI_GEN_COMPLETIONS=1

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
	dobin "$(cargo_target_dir)/yazi"
	use cli && dobin "$(cargo_target_dir)/ya"

	newbashcomp yazi-boot/completions/yazi.bash yazi
	dozshcomp yazi-boot/completions/_yazi
	dofishcomp yazi-boot/completions/yazi.fish

	if use cli; then
		newbashcomp yazi-cli/completions/ya.bash ya
		dozshcomp yazi-cli/completions/_ya
		dofishcomp yazi-cli/completions/ya.fish
	fi

	domenu assets/yazi.desktop
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
