# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo shell-completion

DESCRIPTION="Unofficial Bitwarden CLI"
HOMEPAGE="https://git.tozt.net/rbw"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.tozt.net/rbw"
else
	SRC_URI="https://git.tozt.net/rbw/snapshot/${P}.tar.gz
		${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD Boost-1.0 ISC MIT Unicode-DFS-2016"
# Manually added crate licenses
LICENSE+=" openssl"
SLOT="0"

# copypasta crate provides wayland clipboard support via dlopen calls against
# libwayland-client.so
RDEPEND="app-crypt/pinentry"
BDEPEND=">=virtual/rust-1.74"

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
		"$(cargo_target_dir)"/rbw gen-completions ${comp} > rbw.${comp} || die
	done
	newbashcomp rbw.bash rbw
	dofishcomp rbw.fish
	newzshcomp rbw.zsh _rbw
	einstalldocs
}
