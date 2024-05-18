# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo shell-completion

DESCRIPTION="unofficial bitwarden cli"
HOMEPAGE="https://git.tozt.net/rbw"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.tozt.net/rbw"
else
	SRC_URI="https://git.tozt.net/rbw/snapshot/rbw-${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris ${CRATES})"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install

	rbw gen-completions bash > rbw.bash || die
	dobashcomp rbw.bash

	rbw gen-completions fish > rbw.fish || die
	dofishcomp rbw.fish

	rbw gen-completions zsh > _rbw || die
	dozshcomp _rbw
}
