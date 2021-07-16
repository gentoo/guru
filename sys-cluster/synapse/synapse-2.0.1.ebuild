# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="synapse"
HOMEPAGE="https://github.com/bsc-performance-tools/synapse"
SRC_URI="https://github.com/bsc-performance-tools/synapse/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/boost:=
	sys-cluster/mrnet
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-check-for-shared-mrnet.patch"
	"${FILESDIR}/${PN}-respect-destdir.patch"
	"${FILESDIR}/${PN}-fix-example-installation.patch"
)

src_prepare() {
	sed -e "s|\${prefix}/doc|\${DESTDIR}\${prefix}/share/${PF}/doc|g" -i doc/Makefile.am || die
	default
	./bootstrap || die
}

src_configure() {
	local myconf=(
		--with-mrnet="${EPREFIX}/usr"
	)
	econf "${myconf[@]}"
}

src_install() {
	MAKEOPTS="-j1" DESTDIR="${D}" emake install
	find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
