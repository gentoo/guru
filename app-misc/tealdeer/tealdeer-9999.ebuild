# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=" "

inherit cargo flag-o-matic shell-completion

DESCRIPTION="A very fast implementation of tldr in Rust."
HOMEPAGE="https://github.com/tldr-pages/tldr
	https://github.com/dbrgn/tealdeer"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tealdeer-rs/tealdeer.git"
	src_unpack() {
		git-r3_src_unpack
		cargo_live_src_unpack
	}
else
	SRC_URI="https://github.com/dbrgn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" ${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0 ISC MIT MPL-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD CDLA-Permissive-2.0 ISC MIT Unicode-3.0 ZLIB"
SLOT="0"

RDEPEND="!app-text/tldr"

QA_FLAGS_IGNORED="usr/bin/tldr"

# Tests require network connection
RESTRICT="test"
PROPERTIES="test_network"

src_configure() {
	filter-flags '-flto*' # ring crate fails compile with lto
	cargo_src_configure
}

src_install() {
	cargo_src_install
	einstalldocs

	newbashcomp completion/bash_tealdeer tldr

	newzshcomp completion/zsh_tealdeer _tldr

	newfishcomp completion/fish_tealdeer tldr.fish
}
