# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="https://pagure.io/gfs2-utils"
SRC_URI="https://pagure.io/gfs2-utils/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="nls test"
RESTRICT="!test? ( test )"

BDEPEND="sys-devel/autoconf
		sys-devel/automake
		sys-devel/libtool
		dev-build/make
"
RDEPEND="sys-libs/zlib
		app-arch/bzip2
		sys-libs/ncurses
		sys-apps/util-linux
"

DEPEND="${RDEPEND}
		sys-devel/gettext
		sys-devel/bison
		sys-devel/flex
		test? ( dev-libs/check )
		sys-kernel/linux-headers
"

src_prepare() {
	eapply "${FILESDIR}"/reproducible.patch
	eapply "${FILESDIR}"/gfs2_withdraw_helper.patch
	eapply "${FILESDIR}"/python3.patch
	default
	eautoreconf
}

src_configure() {
			local econf_args
				econf_args=(
				bzip2_LIBS="-L/$(get_libdir) -lbz2"
				bzip2_CFLAGS="-I${prefix}/include"
				)
			ECONF_SOURCE="${S}" econf "${econf_args[@]}"

}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
