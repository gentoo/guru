# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="TUI web browser; supports CSS, images, JavaScript, and multiple web protocols"
HOMEPAGE="https://chawan.net"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~bptato/${PN}"
else
	SRC_URI="https://git.sr.ht/~bptato/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="Unlicense"

SLOT="0"

IUSE="lto"

DEPEND="
	app-arch/brotli
	dev-libs/openssl
	net-libs/libssh2
"
BDEPEND="
	${DEPEND}
	dev-lang/nim
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/makefile-491b4231.patch"
)

src_prepare(){
	default
	if use lto; then
		sed -i -E 's|^FLAGS\s+\+=.+|& -d:lto|' Makefile ||
		die "Trying to sed the Makefile for lto failed!"
	fi
}
