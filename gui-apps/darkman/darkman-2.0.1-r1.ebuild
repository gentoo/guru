# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module

DESCRIPTION="Framework for dark and light mode transitions"
HOMEPAGE="https://gitlab.com/WhyNotHugo/darkman"
SRC_URI="https://gitlab.com/WhyNotHugo/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
	https://codeberg.org/amano-kenji-gentoo-overlay/${PN}/raw/branch/master/${P}-deps.tar.xz"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man +examples"

RDEPEND="app-misc/geoclue"
BDEPEND="man? ( app-text/scdoc )"

DOCS=( CHANGELOG.md README.md )

src_compile() {
	ego build -v -x -o ${PN} -ldflags="-X main.Version=${PV}" ./cmd/${PN}

	if use man; then
		scdoc < ./${PN}.1.scd > ./${PN}.1 || die
	fi
}

src_install() {
	dobin ${PN}

	systemd_douserunit ${PN}.service
	doman ${PN}.1

	use examples && DOCS+=( examples/. )
	einstalldocs

	insinto /usr/share/dbus-1/services
	doins contrib/dbus/*

	insinto  /usr/share/xdg-desktop-portal/portals/
	doins contrib/portal/darkman.portal

	dodir /etc/env.d/
	echo "XDG_DATA_DIRS=\"~/.local/share/\"" >> "${ED}"/etc/env.d/99darkman || die
}
