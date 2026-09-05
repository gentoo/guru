# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A tool to accept licenses in a windows install wizard fashion"
HOMEPAGE="https://gitlab.com/masterwolf/portage-wizard"
SRC_URI="https://gitlab.com/masterwolf/portage-wizard/-/archive/${PV}/${P}.tar.bz2"

S="${WORKDIR}/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-apps/portage
	sys-apps/less
	sys-apps/coreutils
"

DEPEND="${RDEPEND}"

src_prepare()
{
eautoreconf
default
}

src_compile()
{
	emake
}

src_install()
{

dobin emergew

}
