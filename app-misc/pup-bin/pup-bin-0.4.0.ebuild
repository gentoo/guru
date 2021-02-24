# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Parsing HTML at the command line"
HOMEPAGE="https://github.com/ericchiang/pup"
SRC_URI="https://github.com/ericchiang/pup/releases/download/v${PV}/pup_v${PV}_linux_amd64.zip"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	unpack_zip "${DISTDIR}"/pup_v"${PV}"_linux_amd64.zip
}

src_install() {
	dobin pup
}
