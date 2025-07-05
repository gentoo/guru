# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="VCD file (Value Change Dump) command line viewer"
HOMEPAGE="https://github.com/yne/vcd"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/yne/${PN}.git"
else
	SRC_URI="https://github.com/yne/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~loong ~riscv ~x86"
	S="${WORKDIR}/${P}"
fi

LICENSE="MIT"
SLOT="0"

src_compile() {
	# https://bugs.gentoo.org/243502
	emake CC="$(tc-getCC)"
}

src_install() {
	local DOCS=( README.md )
	emake DESTDIR="${ED}" install
	einstalldocs
}
