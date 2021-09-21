# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An implementation of Language Server Protocol for the Rust programming language"
HOMEPAGE="https://rust-analyzer.github.io"
SRC_URI="https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-09-20/rust-analyzer-x86_64-unknown-linux-gnu.gz -> ${P}.gz"

LICENSE="Apache-2.0 MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64"

S=${WORKDIR}

QA_FLAGS_IGNORED="usr/bin/rust-analyzer"

src_install() {
	newbin ${P} rust-analyzer
}

pkg_postinst() {
	elog "Make sure to add your desired rust toolchain (e.g. with rustup) for rust-analyzer to work correctly"
}
