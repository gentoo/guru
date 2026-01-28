# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit wrapper rpm xdg

BLOG_URL="https://www.aimp.ru/blogs/?p=1523&language=en#more-1523"
YADISK_URL="https://disk.yandex.ru/d/yCpF1MnZyM6sLQ"
MY_PN="AIMP"

DESCRIPTION="AIMP - Free Audio Player"
HOMEPAGE="https://www.aimp.ru/"
SRC_URI="
	amd64? ( aimp-$(ver_cut 1-2)-$(ver_cut 3)a.x86_64.rpm )
"
S="${WORKDIR}"

LICENSE="AIMP"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	app-accessibility/at-spi2-core
	app-arch/bzip2
	dev-db/sqlite
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/icu
	dev-libs/libffi
	dev-libs/libpcre2
	media-gfx/graphite2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-sound/opus-tools
	sys-apps/dbus
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/glibc
	virtual/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb
	x11-libs/pango
	x11-libs/pixman
"
RESTRICT="bindist fetch strip"

pkg_nofetch() {
	einfo "Please download \"${SRC_URI}\" from 'nightly builds' link on "
	einfo "'Release Plan' - 'Alpha' section of ${BLOG_URL} "
	einfo "or directrly from 'yandex disk' folder ${YADISK_URL} "
	einfo "and place it in your DISTDIR directory."
}

pkg_setup() {
	QA_PREBUILT="opt/* usr/$(get_libdir)/*"
}

src_unpack() {
	rpm_unpack ${A}
}

src_prepare() {
	default
	rm -rf "${S}"/usr/lib || die
	mv -T "${S}/usr/share/doc/${PN}" "${S}/usr/share/doc/${PF}" || die
	gunzip "usr/share/doc/${PF}/changelog.gz" || die "Failed to decompress docs"
}

src_install() {
	insinto /opt
	doins -r opt/*

	insinto /usr
	doins -r usr/*

	make_wrapper ${MY_PN} "/opt/${PN}/${MY_PN}" "" "/opt/${PN}" "/opt/bin/"
	make_wrapper ${MY_PN}ac "/opt/${PN}/${MY_PN}ac" "" "/opt/${PN}" "/opt/bin/"
	make_wrapper ${MY_PN}ate "/opt/${PN}/${MY_PN}ate" "" "/opt/${PN}" "/opt/bin/"

	fowners root:root "/opt/${PN}/${MY_PN}"
	fowners root:root "/opt/${PN}/${MY_PN}ac"
	fowners root:root "/opt/${PN}/${MY_PN}ate"

	fperms 755 "/opt/${PN}/${MY_PN}"
	fperms 755 "/opt/${PN}/${MY_PN}ac"
	fperms 755 "/opt/${PN}/${MY_PN}ate"
}
