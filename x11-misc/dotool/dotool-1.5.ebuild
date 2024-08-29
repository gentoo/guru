# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd udev

DESCRIPTION="Command to simulate input anywhere"
HOMEPAGE="https://git.sr.ht/~geb/dotool"
EGIT_COMMIT="945a7daedeef076db91261266b802498096f6f91"
SRC_URI="https://git.sr.ht/~geb/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${PV}.tar.gz ${EGO_SUM_SRC_URI}"
SRC_URI+="https://gitlab.com/fictitiousexistence-public/gentoo-gofiles/-/raw/main/dotool/${PN}-${PV}-deps.tar.xz"

S=${WORKDIR}/${PN}-${EGIT_COMMIT}

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

BDEPEND="man? ( app-text/scdoc )"
DEPEND="dev-libs/libinput"
RDEPEND="${DEPEND}"

src_compile() {
	local ldflags="-s -w -X main.Version=${PV}"
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
