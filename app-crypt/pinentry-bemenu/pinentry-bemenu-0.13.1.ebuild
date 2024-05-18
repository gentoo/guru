# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Pinentry based on bemenu"
HOMEPAGE="https://github.com/t-8ch/pinentry-bemenu"
SRC_URI="https://github.com/t-8ch/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/bemenu
	dev-libs/libgpg-error
	dev-libs/libassuan
	dev-libs/popt
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elog "To use pinentry-bemenu, edit your gpg-agent.conf file to include:"
	elog "pinentry-program /usr/bin/pinentry-bemenu"
}
