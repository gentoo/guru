# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A lightweight feed reader with ncurses user interface inspired by Newsboat."
HOMEPAGE="https://codeberg.org/grisha/newsraft"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/grisha/newsraft.git"
else
	SRC_URI="https://codeberg.org/grisha/newsraft/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="ISC"
SLOT="0"

DEPEND="
	dev-db/sqlite:3
	dev-libs/expat
	dev-libs/gumbo:=
	dev-libs/yajl:=
	net-misc/curl
	sys-libs/ncurses:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/newsraft-0.23-hardcoded-CC.patch"
)

src_compile() {
	tc-getCC
	emake CC="${CC}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_test() {
	emake CC="${CC}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" check
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	einstalldocs
}
