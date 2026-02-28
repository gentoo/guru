# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg unpacker wrapper

MY_PN="${PN%-bin}"

DESCRIPTION="OpenAudible is a cross-platform audiobook manager designed for Audible users."
HOMEPAGE="https://openaudible.org/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/OpenAudible_${PV}_x86_64.deb"
S="${WORKDIR}/opt/OpenAudible"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+system-ffmpeg +system-jre +webapp"

BDEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
	net-libs/webkit-gtk
	system-ffmpeg? ( media-video/ffmpeg[lame] )
	system-jre? ( virtual/jre:21 )"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	use system-ffmpeg && rm --force --recursive bin
	use system-ffmpeg || rm --force bin/linux_x86_64/upgrade
	use system-jre && rm --force --recursive jre
	use webapp || rm --force --recursive webapp

	default
}

src_install() {
	insinto /opt/${MY_PN}

	doins -r *

	make_wrapper ${MY_PN} /opt/openaudible/OpenAudible /opt/${MY_PN}
	newicon -s 512 share/icons/hicolor/512x512/apps/org.openaudible.OpenAudible.png ${MY_PN}.png
	make_desktop_entry ${MY_PN}
}
