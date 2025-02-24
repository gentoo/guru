# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ngrok is a reverse proxy, firewall, and API gateway"
HOMEPAGE="https://ngrok.org"
# Each supported arch should get their own bins
SRC_URI="
	amd64? ( https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -> ${P}-amd64.tgz )
	arm? ( https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz -> ${P}-arm.tgz )
	arm64? ( https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz -> ${P}-arm64.tgz )
	mips? ( https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-mips.tgz -> ${P}-mips.tgz )
	ppc64? ( https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-ppc64.tgz -> ${P}-ppc64.tgz )
	s390? ( https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-s390x.tgz -> ${P}-s390.tgz )
	x86? ( https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz -> ${P}-i386.tgz )
"
S="${WORKDIR}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~s390 ~x86"

RESTRICT="mirror strip"
QA_PREBUILT="*"

src_compile() {
:
}

src_install() {
	dobin ngrok
}
