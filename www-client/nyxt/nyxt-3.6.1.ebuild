# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature xdg-utils

DESCRIPTION="Nyxt - the hacker's power-browser"
HOMEPAGE="https://nyxt.atlas.engineer/"

if [[ "${PV}" = *9999* ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/atlas-engineer/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/atlas-engineer/${PN}/releases/download/${PV}/nyxt-${PV}-source-with-submodules.tar.xz -> ${PF}.gh.tar.xz"
fi

# Portage replaces the nyxt binary with scbl when stripping
RESTRICT="mirror strip"

LICENSE="BSD CC-BY-SA-3.0"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-libs/gobject-introspection
	gnome-base/gsettings-desktop-schemas
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-base
	media-libs/gst-plugins-good
	media-libs/gst-plugins-ugly
	media-plugins/gst-plugins-libav
	net-libs/glib-networking
	net-libs/webkit-gtk:4.1
	sys-libs/libfixposix
"

DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lisp/sbcl-2.0.0
"

src_unpack() {
	default

	# nyxt-3-source-with-submodules.tar.xz doesn't unpack in a subdirectory
	# so we create it instead of working directly in ${WORKDIR}
	if [[ "${PV}" != *9999* ]]
	then
		mkdir "${WORKDIR}/${P}" || die
		mv "${WORKDIR}/assets" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/_build" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/build-scripts" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/documents" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/engineer.atlas.Nyxt.yaml" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/examples" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/INSTALL" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/libraries" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/licenses" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/makefile" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/nyxt.asd" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/README.org" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/source" "${WORKDIR}/${P}/" || die
		mv "${WORKDIR}/tests" "${WORKDIR}/${P}/" || die
	fi
}

src_compile() {
	emake all
	use doc && emake doc
}

src_install(){
	dobin "${S}/nyxt"

	if [ "$(use doc)" ]
	then
		docinto "/usr/share/doc/${P}"
		dodoc "${S}/manual.html"
	fi

	newicon -s 512 "${S}/assets/nyxt_512x512.png" nyxt.png
	domenu "${S}/assets/nyxt.desktop"
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	optfeature "for X11 clipboard support" "x11-misc/xclip"
	optfeature "for spellchecking" "app-text/enchant"
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
