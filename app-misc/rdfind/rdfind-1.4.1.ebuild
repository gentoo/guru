# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Find duplicate files"
HOMEPAGE="https://github.com/pauldreik/rdfind"
SRC_URI="https://github.com/pauldreik/rdfind/archive/releases/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

DEPEND="dev-libs/nettle"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-releases-${PV}"

src_prepare() {
	# NOTE: Commands are from bootstrap.sh.
	eaclocal
	eautoheader
	eautomake --add-missing
	eautoconf
	default
}
