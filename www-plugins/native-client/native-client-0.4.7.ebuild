# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Node wrapper for Native Messaging: for web extension to call mpv, for example"
HOMEPAGE="https://github.com/belaviyo/native-client"

SRC_URI="https://github.com/belaviyo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

# TODO add USE flags with browser names
BDEPEND="
	net-libs/nodejs
	|| (
		www-client/firefox
		www-client/firefox-bin
		www-client/firefox-developer-bin
	)
"

src_install() {
	p=/usr/lib/mozilla/native-messaging-hosts/com.add0n.native_client/

	insinto $p
	doins "$FILESDIR/com.add0n.native_client.json"
	doins host.js
	doins "$FILESDIR/run.sh"
}
