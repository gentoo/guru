# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo shell-completion

DESCRIPTION="A command-line tool to generate, analyze, convert and manipulate colors"
HOMEPAGE="https://github.com/sharkdp/pastel"

LICENSE="Apache-2.0 MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT Unicode-DFS-2016"
SLOT="0"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sharkdp/${PN}.git"
else
	SRC_URI="
	https://github.com/sharkdp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
		else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install

	RESOURCES=$(dirname "$(find -type f -name "_pastel")")

	doman $RESOURCES/*.1
	dobashcomp $RESOURCES/pastel.bash
	dofishcomp $RESOURCES/pastel.fish
	dozshcomp $RESOURCES/_pastel
}
