# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PN="bridge-manager"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Beeper Bridge Manager"
HOMEPAGE="https://github.com/beeper/bridge-manager"
SRC_URI="https://github.com/beeper/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/${MY_PN}/releases/download/v${PV}/${MY_P}-vendor.tar.xz
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
# Go dependency licenses
LICENSE+=" BSD BSD-2 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	local BUILD_TIME=$(date -Iseconds)
	local go_ldflags=(
		-X "main.Tag=v${PV}"
		-X "main.BuildTime=${BUILD_TIME}"
	)

	ego build -ldflags "${go_ldflags[*]}" ./cmd/bbctl
}

src_install() {
	dobin bbctl
	einstalldocs

	exeinto /etc/user/init.d
	newexe "${FILESDIR}"/bbctl.initd bbctl
}
