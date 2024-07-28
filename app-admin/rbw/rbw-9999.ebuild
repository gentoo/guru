# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo optfeature shell-completion

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

RDEPEND="app-crypt/pinentry"
BDEPEND=">=virtual/rust-1.75.0"

PATCHES="${FILESDIR}"/${PN}-1.11.1-gen-completions.patch

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

pkg_postinst() {
	if [[ "${REPLACING_VERSIONS%-r*}" = '1.11.1' ]]; then
		elog "If you were affected by issue #163 (getting messages like failed to"
		elog "decrypt encrypted secret: invalid mac when doing any operations on your"
		elog "vault), you will need to rbw sync after upgrading in order to update"
		elog "your local vault with the necessary new data."
	fi
	# copypasta crate provides wayland clipboard support via dlopen calls against
	# libwayland-client.so
	optfeature "Wayland clipboard support" dev-libs/wayland
}
