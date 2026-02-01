# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo shell-completion

DESCRIPTION="Another CMake LSP"
HOMEPAGE="https://github.com/neocmakelsp/neocmakelsp"
SRC_URI="
	https://github.com/neocmakelsp/neocmakelsp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 CC0-1.0 MIT MIT-0 MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	cargo_src_install

	dobashcomp completions/bash/neocmakelsp
	dofishcomp completions/fish/neocmakelsp.fish
	dozshcomp completions/zsh/_neocmakelsp
}
