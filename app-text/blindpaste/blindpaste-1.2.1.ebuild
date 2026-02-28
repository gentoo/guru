# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="a TUI blackboard for quick note taking"
HOMEPAGE="https://projectgrid.net/portfolio/blindpaste"
SRC_URI="https://projectgrid.net/archive/${P}.tar.xz"

S="${WORKDIR}"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"

src_default()
{
	default
}

src_compile()
{
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install()
{
	dobin blindpaste
	einstalldocs
}

pkg_postinst()
{
	elog "Thank you for choosing blindpaste"
	elog "For a better experience with this software, consider adding the line"
	elog "alias bp='blindpaste'"
	elog "to the bottom of ~/.bashrc"
}

pkg_postrm()
{
	elog "Thank you for using blindpaste"
	elog "Don't forget to remove the line"
	elog "alias bp='blindpaste'"
	elog "from ~/.bashrc"
}
