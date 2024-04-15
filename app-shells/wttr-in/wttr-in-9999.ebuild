# Copyright 2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Weather in terminal - just a curl to wttr.in"
HOMEPAGE="https://wttr.in/"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-misc/curl"

S="$WORKDIR"

src_install() {
	dodir /usr/bin/
	echo "curl wttr.in/\$@" > "$ED/usr/bin/weather"
	fperms +x "/usr/bin/weather"
	# TODO add options from https://github.com/chubin/wttr.in#one-line-output
	# TODO wrap in a script to add support of '-h'?
	# TODO add `curl v2.wttr.in/batumi`
}

pkg_postinst() {
	einfo "Run weather command"
	einfo "You can specify the city with 'weather batumi'"
	einfo "For help: 'weather :help'"
}
