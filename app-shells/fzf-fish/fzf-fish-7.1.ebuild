# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Augment your fish command line with fzf key bindings"
HOMEPAGE="https://github.com/PatrickF1/fzf.fish"
SRC_URI="https://github.com/PatrickF1/fzf.fish/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN/-/.}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-apps/fd
	app-shells/fish
	app-shells/fzf
	sys-apps/bat
"

DOCS=( README.md )

src_install() {
	insinto "/usr/share/fish/vendor_completions.d"
	doins completions/*
	insinto "/usr/share/fish/vendor_conf.d"
	doins conf.d/*
	insinto "/usr/share/fish/vendor_functions.d"
	doins functions/*
	einstalldocs
}
