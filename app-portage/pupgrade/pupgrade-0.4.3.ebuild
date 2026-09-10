# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="TUI and CLI wrappers for Gentoo system upgrades"
HOMEPAGE="https://gitlab.com/masterwolf/pupgrade"
SRC_URI="https://gitlab.com/masterwolf/pupgrade/-/archive/${PV}/pupgrade-${PV}.tar.bz2"

S="${WORKDIR}/pupgrade-${PV}/source"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
dev-util/dialog
app-shells/bash
"

DEPEND="${RDEPEND}"

src_prepare() {
eautoreconf
default
}

src_compile() {

emake
}

src_install() {
dobin pupgrade
newbin "${WORKDIR}/${P}/bash/tuipupgrade" "tuipupgrade"

}
