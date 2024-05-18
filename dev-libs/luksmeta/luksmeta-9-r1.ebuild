# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="LUKSMeta is a simple library for storing metadata in the LUKSv1 header"
HOMEPAGE="https://github.com/latchset/luksmeta"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

DEPEND="sys-fs/cryptsetup"
RDEPEND="${DEPEND}"
BDEPEND="man? ( app-text/asciidoc )
	dev-build/libtool"

PATCHES=(
	# https://bugs.gentoo.org/837308
	"${FILESDIR}/${PN}-tests.patch"
)

src_prepare() {
	default
	eautoreconf
	# Bug https://bugs.gentoo.org/921710
	sed -i -e '/^-Werror \\$/d' configure.ac || die
}

src_install() {
	default
	# Bug https://bugs.gentoo.org/839609
	find "${ED}" -name '*.la' -delete || die
}
