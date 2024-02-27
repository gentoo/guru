# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="A cross-platform media center, famous for high quality of audio."
HOMEPAGE="https://jriver.com/"
SRC_URI="https://files.jriver-cdn.com/mediacenter/channels/v31/latest/MediaCenter-${PV}-amd64.deb"

S="${WORKDIR}"

SLOT="0"

LICENSE="all-rights-reserved"
KEYWORDS="~amd64"

RESTRICT="strip"
QA_PREBUILT="*"

# TODO soon brotli dep will be dropped
RDEPEND="
	app-arch/brotli
	media-libs/alsa-lib
	media-libs/libglvnd
	x11-libs/gtk+
	x11-libs/pango
	x11-libs/libXrandr
"

src_unpack() {
	unpack_deb ${A}
}

src_install() {

	# To solve this https://bugs.gentoo.org/915528
	# "
	# * This location is deprecated, it should not be used anymore by new software.
	# * Appdata/Metainfo files should be installed into /usr/share/metainfo directory.
	# * For more details, please see the freedesktop Upstream Metadata guidelines at
	# * https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html
	# "
	# I wrote to upstream https://yabb.jriver.com/interact/index.php/topic,138293.0.html
	mv usr/share/appdata usr/share/metainfo

	cp -R "${S}"/* "${D}" || die "Installing binary files failed"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
