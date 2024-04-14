# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature xdg

DESCRIPTION="Nyxt - the hacker's power-browser"
HOMEPAGE="https://nyxt.atlas.engineer/"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/atlas-engineer/${PN}.git"
	EGIT_SUBMODULES=( '*' )
	EGIT_BRANCH="master"
	EGIT_CHECKOUT_DIR="${S}"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/atlas-engineer/${PN}/releases/download/${PV}/nyxt-${PV}-source-with-submodules.tar.xz -> ${PF}.gh.tar.xz"
fi

# Portage replaces the nyxt binary with sbcl when stripping
RESTRICT="mirror strip"

LICENSE="BSD CC-BY-SA-3.0"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-libs/gobject-introspection
	gnome-base/gsettings-desktop-schemas
	net-libs/glib-networking
	net-libs/webkit-gtk:4.1
	sys-libs/libfixposix
"

DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lisp/sbcl-2.0.0
"
QA_FLAGS_IGNORED="usr/bin/${PN}"

if [[ "${PV}" != 9999 ]]; then
	src_unpack() {
		mkdir "${WORKDIR}/${P}" || die
		cd "${WORKDIR}/${P}"
		default
}

fi

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

	for icon in 16x16 32x32  128x128 256x256 512x512; do
		newicon -s ${icon} "${S}/assets/nyxt_${icon}.png" ${PN}.png
	done

	domenu "${S}/assets/nyxt.desktop"
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "for X11 clipboard support" "x11-misc/xclip"
	optfeature "for spellchecking" "app-text/enchant"
	optfeature "for HTML5 audio/video" "media-libs/gstreamer"
	optfeature "for HTML5 audio/video" "media-libs/gst-plugins-bad"
	optfeature "for HTML5 audio/video" "media-libs/gst-plugins-base"
	optfeature "for HTML5 audio/video" "media-libs/gst-plugins-good"
	optfeature "for HTML5 audio/video" "media-libs/gst-plugins-ugly"
	optfeature "for HTML5 audio/video" "media-plugins/gst-plugins-libav"
}

pkg_postrm() {
	xdg_pkg_postrm
}
