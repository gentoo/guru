# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="XOAUTH2 mechanism plugin for cyrus-sasl"
HOMEPAGE="https://github.com/moriyoshi/cyrus-sasl-xoauth2"
SRC_URI="https://github.com/moriyoshi/cyrus-sasl-xoauth2/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/cyrus-sasl"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "s|/lib/sasl2|/$(get_libdir)/sasl2|" Makefile.am || die
	default
	./autogen.sh
	eautoreconf
}

src_install() {
	default
	find "${ED}" -type f -name '*.la' -delete || die
}
