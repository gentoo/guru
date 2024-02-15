# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="A cross-platform media center, famous for high quality of audio."
HOMEPAGE="https://jriver.com/"
SRC_URI="https://files.jriver-cdn.com/mediacenter/test/MediaCenter-31.0.60-amd64.deb"

S="${WORKDIR}"

SLOT="0"

LICENSE="all-rights-reserved"
KEYWORDS="~amd64"

RESTRICT="strip"
QA_PREBUILT="*"

RDEPEND="
	app-arch/brotli
"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	cp -R "${S}"/* "${D}" || die "Installing binary files failed"
}
