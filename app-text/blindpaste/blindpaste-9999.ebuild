# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="a TUI blackboard for quick note taking"
HOMEPAGE="https://projectgrid.net/portfolio/blindpaste"
EGIT_REPO_URI="https://git.projectgrid.net/blindpaste.git"

LICENSE="0BSD"
SLOT="0"
KEYWORDS=""

src_compile()
{
	emake CC="$(tc-getCC)"
}

src_install()
{
	emake DESTDIR="${D}" install
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
