# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 shell-completion

DESCRIPTION="An integrated language service for Typst."
HOMEPAGE="https://github.com/Myriad-Dreamin/tinymist"
EGIT_REPO_URI="https://github.com/Myriad-Dreamin/tinymist"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC0-1.0
	EUPL-1.2 ISC LGPL-3+ MIT MPL-2.0 Unicode-3.0 Unicode-DFS-2016 ZLIB
"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	cargo_src_configure --frozen
}

src_compile() {
	cargo_src_compile

	"$(cargo_target_dir)"/tinymist completion bash > tinymist || die
	"$(cargo_target_dir)"/tinymist completion fish > tinymist.fish || die
	"$(cargo_target_dir)"/tinymist completion zsh > _tinymist || die
}

src_install() {
	cargo_src_install --path ./crates/tinymist

	dobashcomp tinymist
	dofishcomp tinymist.fish
	dozshcomp _tinymist
}
