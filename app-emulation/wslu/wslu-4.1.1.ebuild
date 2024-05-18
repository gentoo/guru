# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of utilities for Windows Subsystem for Linux"
HOMEPAGE="https://wslutiliti.es/wslu/"
SRC_URI="https://github.com/wslutilities/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

RESTRICT="test"

RDEPEND="
	app-shells/bash-completion
	sys-devel/bc
	sys-process/psmisc
"

PATCHES=(
	"${FILESDIR}"/${PN}-dont-compress-manpages.patch #916991
)

src_install() {
	emake DESTDIR="${D}" install
	dodoc README.md
}
