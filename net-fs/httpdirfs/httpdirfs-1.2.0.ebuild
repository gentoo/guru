# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Filesystem to mount HTTP directory listings, with a permanent cache"
HOMEPAGE="https://github.com/fangfufu/httpdirfs"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fangfufu/${PN}.git"
else
	SRC_URI="https://github.com/fangfufu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="test"
LICENSE="GPL-3"
SLOT="0"
# Doc generation fails
# uses app-text/doxygen[dot]
# IUSE="doc"

DEPEND="
	dev-libs/expat
	dev-libs/gumbo
	net-misc/curl
	sys-fs/e2fsprogs
	sys-fs/fuse:0
"
RDEPEND="${DEPEND}"

src_compile () {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake prefix="${D}/usr" install
}
