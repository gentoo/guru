# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="Augment your fish command line with fzf key bindings"
HOMEPAGE="https://github.com/PatrickF1/fzf.fish"
SRC_URI="https://github.com/PatrickF1/fzf.fish/archive/refs/tags/v${PV}.tar.gz -> fzf-fish-${PV}.tar.gz"
S="${WORKDIR}/${PN/-/.}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-shells/fish-3.4.0
	>=app-shells/fzf-0.33
	>=sys-apps/bat-0.16.0
	>=sys-apps/fd-8.5.0
"
DEPEND="${RDEPEND}"
BDEPEND=""

src_install() {
	dofishcomp completions/*
	insinto "/usr/share/fish/vendor_conf.d"
	doins conf.d/*
	insinto "/usr/share/fish/vendor_functions.d"
	doins functions/*
	einstalldocs
}
