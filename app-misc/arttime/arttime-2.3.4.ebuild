# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="CLI application that blends beauty of ASCII"
HOMEPAGE="https://github.com/poetaman/arttime"
SRC_URI="https://github.com/poetaman/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-shells/zsh
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	default
	gunzip share/man/man1/arttime.1.gz || die
	gunzip share/man/man1/artprint.1.gz || die
}

src_install() {
	dobin bin/arttime
	dobin bin/artprint

	insinto /usr/share/${PN}
	doins -r share/${PN}/src
	doins -r share/${PN}/textart
	doins -r share/${PN}/keypoems

	doman share/man/man1/arttime.1
	doman share/man/man1/artprint.1

	dodoc README.md
}

pkg_postinst() {
	optfeature "Desktop notifications" x11-libs/libnotify
}
