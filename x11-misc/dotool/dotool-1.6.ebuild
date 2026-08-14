# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd udev

DESCRIPTION="Command to simulate input anywhere"
HOMEPAGE="https://git.sr.ht/~geb/dotool"
EGIT_COMMIT="180af21c46dcc848d93dbec2644c011f4eea1592"
SRC_URI="https://git.sr.ht/~geb/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${PV}.tar.gz ${EGO_SUM_SRC_URI}"
SRC_URI+="https://codeberg.org/fictitiousexistence/gentoo-depfiles/media/branch/main/dotool/${PN}-${PV}-deps.tar.xz"

S=${WORKDIR}/${PN}-${EGIT_COMMIT}

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

BDEPEND="man? ( app-text/scdoc )"
DEPEND="dev-libs/libinput
		x11-libs/libxkbcommon"
RDEPEND="${DEPEND}"

src_compile() {
	local ldflags="-X main.Version=${PV}"
	go build -ldflags="${ldflags}" || die 'go build failed'
	use man && scdoc < ./doc/${PN}.1.scd  > ./${PN}.1
}

src_install() {
	dobin ${PN} ${PN}c ${PN}d
	udev_dorules 80-${PN}.rules
	systemd_douserunit "${FILESDIR}/${PN}d.service"
	newinitd "${FILESDIR}/dotoold.initd" dotoold
	use man && doman ${PN}.1

}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
