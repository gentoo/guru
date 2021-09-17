# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg-utils savedconfig toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/nsxiv/nsxiv.git"
	inherit git-r3
else
	SRC_URI="https://github.com/nsxiv/nsxiv/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Neo (or New or Not) Simple (or Small or Suckless) X Image Viewer"
HOMEPAGE="https://github.com/nsxiv/nsxiv"

LICENSE="GPL-2"
SLOT="0"
IUSE="exif gif +jpeg +png webp tiff"

RDEPEND="
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib:0= )
	media-libs/imlib2[X,gif?,jpeg?,png?,webp?,tiff?]
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	restore_config config.h
}

src_configure() {
	sed -i \
		-e '/-include config.mk/d' \
		-e '/\$(OBJS): / s|config.mk||' \
		-e '/^install: / s|: all|:|' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" HAVE_LIBEXIF=$(usex exif 1 0) HAVE_LIBGIF=$(usex gif 1 0)
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
	emake -C icon DESTDIR="${ED}" PREFIX=/usr install
	dodoc README.md
	domenu nsxiv.desktop

	save_config config.h
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
