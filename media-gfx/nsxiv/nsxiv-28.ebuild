# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg-utils savedconfig toolchain-funcs linux-info

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
IUSE="+statusbar exif +inotify +gif +jpeg +png webp tiff"

RDEPEND="
	statusbar? ( x11-libs/libXft )
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib:0= )
	webp? ( media-libs/libwebp )
	media-libs/imlib2[X,gif?,jpeg?,png?,webp?,tiff?]
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

pkg_setup() {
	if use inotify; then
		CONFIG_CHECK+=" ~INOTIFY_USER"
		ERROR_INOTIFY_USER="${P} requires inotify in-kernel support."
		linux-info_pkg_setup
	fi
}

src_prepare() {
	default

	restore_config config.h
}

src_configure() {
	sed -i  -e '/^install: / s|: all|:|' \
		-e 's|^CFLAGS ?=|CFLAGS +=|' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" OPT_DEP_DEFAULT=0 \
		HAVE_INOTIFY="$(usex inotify 1 0)" \
		HAVE_LIBFONTS="$(usex statusbar 1 0)" \
		HAVE_LIBGIF="$(usex gif 1 0)" \
		HAVE_LIBWEBP="$(usex webp 1 0)" \
		HAVE_LIBEXIF="$(usex exif 1 0)"
}

src_install() {
	export DESTDIR="${ED}"
	export PREFIX="/usr"
	export EGPREFIX="${PREFIX}/share/doc/${P}/examples"

	emake install
	emake install-icon
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
