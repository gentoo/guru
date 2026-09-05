# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="TUI and CLI wrappers for Gentoo system upgrades, written in B and C"
HOMEPAGE="https://gitlab.com/masterwolf/pupgrade"
SRC_URI="https://gitlab.com/masterwolf/pupgrade/-/archive/${PV}/pupgrade-${PV}.tar.bz2"

S="${WORKDIR}/pupgrade-${PV}/source"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="tui"

RDEPEND="
	dev-util/dialog
	app-shells/bash
"

BDEPEND="
	tui? ( sys-devel/b )
"

src_prepare() {
	eautoreconf
	default
}

src_compile() {

emake
}

src_install() {
	dobin pupgrade

	if use tui; then
		dobin tuipupgrade
	fi

}

QA_FLAGS_IGNORED="/usr/bin/tuipupgrade"
