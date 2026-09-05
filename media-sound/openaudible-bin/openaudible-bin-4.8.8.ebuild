# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg unpacker wrapper

MY_PN="${PN%-bin}"

DESCRIPTION="OpenAudible is a cross-platform audiobook manager designed for Audible users"
HOMEPAGE="https://openaudible.org/"
SRC_URI="
	amd64? (
		https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/OpenAudible_${PV}_x86_64.deb
	)
"
S="${WORKDIR}/opt/OpenAudible"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

BDEPEND="app-arch/unzip"
RDEPEND="
	net-libs/webkit-gtk
	virtual/jre:21
"

QA_PREBUILT="*"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	rm --force --recursive jre || die

	default
}

src_install() {
	insinto /opt/${MY_PN}
	exeinto /opt/${MY_PN}

	doins -r *
	doins -r .install4j
	doexe OpenAudible

	exeinto /opt/${MY_PN}/bin/linux_x86_64/
	doexe bin/linux_x86_64/ffmpeg

	make_wrapper ${MY_PN} /opt/openaudible/OpenAudible /opt/${MY_PN}
	newicon -s 512 share/icons/hicolor/512x512/apps/org.openaudible.OpenAudible.png ${MY_PN}.png
	make_desktop_entry ${MY_PN}
}
