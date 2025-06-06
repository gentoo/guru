# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Simple passphrase entry dialog via 'fuzzel'."
HOMEPAGE="https://github.com/JonasToth/pinentry-fuzzel"
SRC_URI="https://github.com/JonasToth/pinentry-fuzzel/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-apps/fuzzel
"

src_install() {
	dobin pinentry-fuzzel
}

pkg_postinst() {
	elog "To use pinentry-fuzzel, edit your gpg-agent.conf file to include:"
	elog "pinentry-program /usr/bin/pinentry-fuzzel"
	elog "Consider adding 'password-character=●' to your '~/.config/fuzzel/fuzzel.ini' file"
}
