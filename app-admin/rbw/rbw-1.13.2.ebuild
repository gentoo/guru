# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.75.0"

inherit cargo shell-completion

DESCRIPTION="Unofficial Bitwarden CLI"
HOMEPAGE="https://git.tozt.net/rbw"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.tozt.net/rbw"
else
	SRC_URI="
		https://git.tozt.net/rbw/snapshot/${P}.tar.gz
		https://github.com/pastalian/distfiles/releases/download/${P}/${P}-crates.tar.xz
	"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD Boost-1.0 ISC MIT Unicode-3.0"
# Manually added crate licenses
LICENSE+=" openssl"
SLOT="0"

RDEPEND="app-crypt/pinentry"

QA_FLAGS_IGNORED="
	usr/bin/rbw
	usr/bin/rbw-agent
"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_compile() {
	# cc-rs picks up CFLAGS from the env
	export CFLAGS
	cargo_src_compile
}

src_install() {
	cargo_src_install

	local comp DOCS="CHANGELOG.md README.md"
	for comp in bash fish zsh; do
		"$(cargo_target_dir)"/rbw gen-completions ${comp} > rbw.${comp} || \
			die "Failed to generate completions for ${comp}."
	done
	newbashcomp rbw.bash rbw
	dofishcomp rbw.fish
	newzshcomp rbw.zsh _rbw
	einstalldocs
}
