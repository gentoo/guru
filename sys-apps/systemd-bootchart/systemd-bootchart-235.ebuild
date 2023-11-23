# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools

DESCRIPTION="systemd boot performance graphing tool"
HOMEPAGE="https://github.com/systemd/systemd-bootchart"
SRC_URI="https://github.com/systemd/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

BDEPEND="app-text/docbook-xml-dtd:4.2
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt:0"

RDEPEND="systemd? ( >=sys-apps/systemd-221 )"

CONFIG_CHECK="SCHEDSTATS ~SCHED_DEBUG"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_with systemd libsystemd)
}
