# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs xdg

DESCRIPTION="Modern, beautiful IRC client written in GTK+ 3"
HOMEPAGE="https://github.com/SrainApp/srain"
SRC_URI="https://github.com/SrainApp/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="debug"

RDEPEND="
	>=x11-libs/gtk+-3.22.0
	x11-libs/libnotify
"
DEPEND="
	${RDEPEND}
	app-crypt/libsecret
	dev-libs/libconfig
	net-libs/libsoup
"

src_configure() {
	econf $(use_enable debug)
}

src_compile() {
	tc-export CC
	default
}
