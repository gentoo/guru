# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} )

inherit python-any-r1

DESCRIPTION="ANother Auto NICe daemon"
HOMEPAGE="https://github.com/Nefelim4ag/Ananicy"
SRC_URI="https://github.com/Nefelim4ag/Ananicy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="sys-apps/systemd"
S="${WORKDIR}/${P^}"
DOCS=( README.md )

src_compile() {
	return
}

src_install() {
	emake PREFIX="${ED}" install
	python_fix_shebang "${ED}/usr/bin/ananicy"
	einstalldocs
}
