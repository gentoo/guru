# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=" "

inherit cargo flag-o-matic shell-completion

DESCRIPTION="A very fast implementation of tldr in Rust."

HOMEPAGE="https://github.com/tldr-pages/tldr
	https://github.com/dbrgn/tealdeer"

SRC_URI="https://github.com/dbrgn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-r1-deps.tar.xz/${P}-r1-deps.tar.xz"
ECARGO_VENDOR="${WORKDIR}/vendor"

LICENSE="Apache-2.0 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

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
