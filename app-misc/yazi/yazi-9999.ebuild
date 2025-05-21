# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 desktop shell-completion xdg

DESCRIPTION="Blazing fast terminal file manager written in Rust, based on async I/O."
HOMEPAGE="https://yazi-rs.github.io"
EGIT_REPO_URI="https://github.com/sxyazi/yazi.git"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
CC0-1.0 ISC MIT MPL-2.0 UoI-NCSA Unicode-3.0 ZLIB
"

SLOT="0"
IUSE="+cli"

QA_FLAGS_IGNORED="
usr/bin/ya.*
"

RDEPEND="
dev-libs/oniguruma
"
DEPEND="${RDEPEND}"

DOCS=(
	"README.md"
	"yazi-config/preset/keymap-default.toml"
	"yazi-config/preset/theme-dark.toml"
	"yazi-config/preset/theme-light.toml"
	"yazi-config/preset/yazi-default.toml"
)

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	export YAZI_GEN_COMPLETIONS=true
	sed -i -r 's/strip\s+= true/strip = false/' Cargo.toml || die "Sed failed!"
	eapply_user
}

src_compile() {
	# workaround for GCC 15 issues:
	# unvendor libonig from rust-onig. see bugs 943785, 945008
	export RUSTONIG_SYSTEM_LIBONIG=1
	cargo_src_compile
	use cli && cargo_src_compile -p "${PN}-cli"
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
	einstalldocs
}
