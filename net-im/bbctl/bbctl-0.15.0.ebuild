# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

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
LICENSE+=" BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-db/sqlite:3"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	local BUILD_TIME=$(date -Iseconds)
	local go_ldflags=(
		-X "main.Tag=v${PV}"
		-X "main.Commit=unknown"
		-X "main.BuildTime=${BUILD_TIME}"
	)

	# https://github.com/mattn/go-sqlite3#linux
	# -tags libsqlite3: use system sqlite3 instead of bundled
	ego build -tags "libsqlite3" -ldflags "${go_ldflags[*]}" ./cmd/bbctl
}

src_install() {
	dobin bbctl
	einstalldocs

	exeinto /etc/user/init.d
	newexe "${FILESDIR}"/bbctl.initd bbctl
}
