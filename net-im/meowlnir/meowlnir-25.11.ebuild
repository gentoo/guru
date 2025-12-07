# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PV="0.$(ver_rs 1-2 '').0"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Opinionated Matrix moderation bot"
HOMEPAGE="https://github.com/maunium/meowlnir"
SRC_URI="https://github.com/maunium/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/meowlnir/releases/download/v${MY_PV}/${MY_P}-vendor.tar.xz
"
S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/meowlnir
	dev-libs/olm
"
DEPEND="${RDEPEND}"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	local MAUTRIX_VERSION=$(awk '/maunium\.net\/go\/mautrix / { print $2 }' go.mod)
	local BUILD_TIME=$(date -Iseconds)
	local go_ldflags=(
		-X "main.Tag=v${MY_PV}"
		-X "main.BuildTime=${BUILD_TIME}"
		-X "maunium.net/go/mautrix.GoModVersion=${MAUTRIX_VERSION}"
	)

	local -x GOEXPERIMENT=jsonv2
	ego build -ldflags "${go_ldflags[*]}" ./cmd/meowlnir
}

src_install() {
	dobin meowlnir
	newinitd "${FILESDIR}"/meowlnir.initd meowlnir
	einstalldocs

	insinto /etc/meowlnir
	doins config/example-config.yaml

	fowners -R meowlnir:meowlnir /etc/meowlnir
	fperms 750 /etc/meowlnir

	keepdir /var/lib/meowlnir
	fowners -R meowlnir:meowlnir /var/lib/meowlnir
}
