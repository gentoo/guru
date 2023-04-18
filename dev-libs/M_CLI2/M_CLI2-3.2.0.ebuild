# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit fortran-2 meson

DESCRIPTION="M_CLI2 - parse Unix-like command line arguments from Fortran"
HOMEPAGE="https://github.com/urbanjost/M_CLI2"
SRC_URI="https://github.com/urbanjost/${PN}/archive/refs/tags/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test"

RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/${P}_fix_meson_install_rules.patch" )

src_configure() {
	use !static-libs && local emesonargs+=( -Ddefault_library=shared )
	meson_src_configure
}
