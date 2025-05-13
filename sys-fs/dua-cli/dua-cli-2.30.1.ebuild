# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo

DESCRIPTION="A tool to conveniently learn about the disk usage of directories, fast!"
HOMEPAGE="https://github.com/Byron/dua-cli"
SRC_URI="https://github.com/Byron/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
DEPS_URI="https://github.com/freijon/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/dua"

DOCS=(
	README.md
	CHANGELOG.md
)

src_install() {
	cargo_src_install
	dodoc -r "${DOCS[@]}"
}
