# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="a CLI version control system with a CI/CD pipeline"
HOMEPAGE="https://projectgrid.net/portfolio/gittorrent"
EGIT_REPO_URI="https://git.projectgrid.net/gittorrent.git"

LICENSE="0BSD"
SLOT="0"
KEYWORDS=""

BDEPEND=">=virtual/rust-1.75.0"

src_unpack()
{
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile()
{
	cargo_src_compile
}

src_install()
{
	cargo_src_install
	einstalldocs
}

pkg_postinst()
{
	elog "Thank you for choosing gittorrent"
	elog "For a better experience with this software, consider adding the line"
	elog "alias gt='gittorrent'"
	elog "to the bottom of ~/.bashrc"
}

pkg_postrm()
{
	elog "Thank you for using gittorrent"
	elog "Don't forget to remove the line"
	elog "alias gt='gittorrent'"
	elog "from ~/.bashrc"
}
