# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools multilib-minimal

DESCRIPTION="OpenGL Easy Extension library"
HOMEPAGE="https://elf-stone.com/glee.php"
SRC_URI="https://elf-stone.com/downloads/GLee/GLee-${PV}-src.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="virtual/opengl[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

src_unpack() {
	mkdir "${P}" || die
	cd "${P}" || die
	default
}

src_prepare() {
	default
	eapply -p0 "${FILESDIR}/${PN}-autotools.patch"
	eautoreconf || die
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(use_enable static-libs static)
}

multilib_src_install() {
	emake DESTDIR="${D}" install || die
	find "${ED}" -type f -name '*.la' -delete || die
	dodoc readme.txt extensionList.txt || die
	insinto /usr/$(get_libdir)/pkgconfig
	doins glee.pc
}
