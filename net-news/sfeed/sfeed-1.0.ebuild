# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="simple RSS and Atom parser"
HOMEPAGE="https://www.codemadness.org/sfeed.html"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.codemadness.org/sfeed"
else
	SRC_URI="https://www.codemadness.org/releases/sfeed/sfeed-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

src_compile() {
	tc-export AR CC
	emake RANLIB=$(tc-getRANLIB)
}

src_install() {
	DESTDIR="${D}" \
		emake install \
		PREFIX="/usr" \
		MANPREFIX="/usr/share/man" \
		DOCPREFIX="/usr/share/doc/${P}"

	einstalldocs
}
