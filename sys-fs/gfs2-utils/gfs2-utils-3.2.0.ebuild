# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs linux-info

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="https://sourceware.org/cluster/gfs/"
SRC_URI="https://releases.pagure.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="nls"

RDEPEND="sys-libs/zlib
		sys-apps/util-linux
		sys-libs/ncurses"

DEPEND="${RDEPEND}
		sys-devel/autoconf
		sys-devel/automake
		sys-devel/libtool
		sys-devel/make
		sys-devel/gettext
		sys-devel/bison
		sys-devel/flex
		sys-libs/zlib"

src_prepare() {
	eapply "${FILESDIR}"/reproducible.patch
	eapply "${FILESDIR}"/gfs2_withdraw_helper.patch
	eapply "${FILESDIR}"/python3.patch
	eapply "${FILESDIR}"/bashism.patch
	eapply "${FILESDIR}"/ftbfs-gcc9.patch
	eapply "${FILESDIR}"/udev-rules.patch
	default
	./autogen.sh
	eautoreconf
}

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
