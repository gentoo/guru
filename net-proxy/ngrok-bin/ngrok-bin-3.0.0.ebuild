# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ngrok is a reverse proxy, firewall, and API gateway"
HOMEPAGE="https://ngrok.org"
# Each supported arch should get their own bins
SRC_URI="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
S="${WORKDIR}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

src_compile() {
 :
}

src_install() {
    dobin ngrok
}