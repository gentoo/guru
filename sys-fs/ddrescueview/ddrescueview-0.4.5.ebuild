# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-source-${PV}"

inherit edo

DESCRIPTION="Graphical viewer for GNU ddrescue mapfiles"
HOMEPAGE="https://sourceforge.net/projects/ddrescueview/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-lang/lazarus
"

# I don't know yet how not to strip debug info during lazbuild build
QA_PRESTRIPPED="usr/bin/ddrescueview"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cd source || die
	edo lazbuild \
		--lazarusdir=/usr/share/lazarus \
		--primary-config-path="${HOME}" \
		--skip-dependencies \
		--verbose \
		ddrescueview.lpi
	default
}

src_install() {
	dobin source/ddrescueview

	insinto /usr/share
	doins -r resources/linux/applications
	doins -r resources/linux/icons
	doman resources/linux/man/man1/ddrescueview.1

	dodoc changelog.txt
	dodoc readme.txt
	default
}
