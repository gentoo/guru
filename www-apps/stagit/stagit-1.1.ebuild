# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="static git page generator"
HOMEPAGE="https://codemadness.org/stagit.html"
SRC_URI="https://codemadness.org/releases/stagit/stagit-1.1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/libgit2"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" MANPREFIX="${EPREFIX}/usr/share/man" DOCPREFIX="${EPREFIX}/usr/share/doc/${P}" install
}
