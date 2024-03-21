# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A meme system info tool for Linux"
HOMEPAGE="https://github.com/TheDarkBug/uwufetch"
SRC_URI="https://github.com/TheDarkBug/uwufetch/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

PATCHES=(
	"${FILESDIR}/${P}-destdir.patch"
)

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-apps/xwininfo"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply -p0 "${FILESDIR}/${P}-destdir.patch"
	eapply -p0 "${FILESDIR}/${P}-lib64.patch"
	eapply -p0 "${FILESDIR}/${P}-includedir.patch"
	eapply -p0 "${FILESDIR}/${P}-mkinclude.patch"

	eapply_user
}

src_compile() {
	emake build
	cp libfetch.so "libfetch.so.1"
}

src_install() {
	emake DESTDIR="${D}/usr" install

	mv "${D}/usr/etc" "${D}/etc"

	doman uwufetch.1
	dolib.so libfetch.so.1
	dosym "libfetch.so.1" "/usr/$(get_libdir)/libfetch.so.1"
}
