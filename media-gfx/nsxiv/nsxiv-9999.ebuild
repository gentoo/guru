# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils savedconfig toolchain-funcs linux-info shell-completion

ZSH_COMP_COMMIT="f7d1efe3495949e2e88fdfef37aed5a40400acea"
ZSH_COMP_URI="https://codeberg.org/nsxiv/nsxiv-extra/raw/commit/${ZSH_COMP_COMMIT}/completion/zsh/_nsxiv"
ZSH_COMP="${PN}-${ZSH_COMP_COMMIT}.comp.zsh"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://codeberg.org/nsxiv/nsxiv.git"
	SRC_URI="${ZSH_COMP_URI} -> ${ZSH_COMP}"
	inherit git-r3
else
	SRC_URI="
		https://codeberg.org/nsxiv/nsxiv/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${ZSH_COMP_URI} -> ${ZSH_COMP}
	"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Neo (or New or Not) Simple (or Small or Suckless) X Image Viewer"
HOMEPAGE="https://codeberg.org/nsxiv/nsxiv"

LICENSE="GPL-2+ public-domain"
SLOT="0"
IUSE="+statusbar +inotify exif debug"

RDEPEND="
	x11-libs/libX11
	>=media-libs/imlib2-1.8.0[X]
	statusbar? ( x11-libs/libXft media-libs/fontconfig )
	exif? ( media-libs/libexif )
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
	# avoid rebuild on `make install`
	sed -i -e '/^install: / s|: all|:|' Makefile || die
}

src_compile() {
	local dbg=""
	use debug && dbg="-UNDEBUG -DDEBUG"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${dbg}" \
		OPT_DEP_DEFAULT=0 \
		HAVE_INOTIFY="$(usex inotify 1 0)" \
		HAVE_LIBFONTS="$(usex statusbar 1 0)" \
		HAVE_LIBEXIF="$(usex exif 1 0)"
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		PREFIX="/usr" \
		EGPREFIX="/usr/share/doc/${P}/examples" \
		install install-icon
	dodoc README.md
	domenu etc/nsxiv.desktop
	newzshcomp "${DISTDIR}/${ZSH_COMP}" _nsxiv

	save_config config.h
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update

	einfo "${PN} uses media-libs/imlib2 for loading images."
	einfo "To enable/disable support for specific image formats,"
	einfo "toggle the necessary USE flag for media-libs/imlib2."
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
