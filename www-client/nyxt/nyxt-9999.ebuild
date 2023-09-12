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
	NYXTCOMMIT="27612fee394f80dee6480c045ec7da5cd1f82196"
	S="${WORKDIR}/${PN}-${NYXTCOMMIT}"

	# Specify commits for each submodules
	# Some regex substitutions allows to automate this process...
	# Commit hashes are obtained from -9999 version on ${NYXTCOMMIT}
	# Full list can be found here: https://github.com/atlas-engineer/nyxt/tree/master/_build
	# Removed the commits to reduce useless lines in -9999 version

	SRC_URI="https://github.com/atlas-engineer/${PN}/archive/${NYXTCOMMIT}.tar.gz -> ${P}.gh.tar.gz"
	# Removed the submodules SRC_URIs to reduce useless lines in -9999 version
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
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_unpack() {
	default

	# Unpack the submodules in the _build directory
	if [[ "${PV}" != *9999* ]]
	then
		# Removed src_unpack to reduce useless lines in -9999
		true
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

	doicon "${S}/assets/icon_512x512.png.ico"
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
