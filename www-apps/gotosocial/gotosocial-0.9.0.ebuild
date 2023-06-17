# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd tmpfiles

DESCRIPTION="Fast, fun, ActivityPub server, powered by Go"
HOMEPAGE="
	https://gotosocial.org/
	https://github.com/superseriousbusiness/gotosocial
"
GH_RELEASE="https://github.com/superseriousbusiness/${PN}/releases/download/v${PV}"
SRC_URI="
	${GH_RELEASE}/${P}-source-code.tar.gz
	${GH_RELEASE}/${PN}_${PV}_web-assets.tar.gz
"
S="${WORKDIR}"

LICENSE="|| ( WTFPL-2 CC0-1.0 ) AGPL-3 Apache-2.0 BSD BSD-2 CC0-1.0 GPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

# Flaky tests
RESTRICT="test"

RDEPEND="acct-user/gotosocial"

DOCS=( archive {CONTRIBUTING,README,ROADMAP}.md )

src_unpack() {
	# source code
	unpack ${P}-source-code.tar.gz
	rm -r web || die

	# prebuilt web assets
	unpack ${PN}_${PV}_web-assets.tar.gz
}

src_prepare() {
	default

	sed -i example/config.yaml \
		-e "s|./web/template/|${EPREFIX}/usr/share/gotosocial/web/template/|g" \
		-e "s|./web/assets/|${EPREFIX}/usr/share/gotosocial/web/assets/|g" \
		-e "s|/gotosocial/storage|${EPREFIX}/var/lib/gotosocial/storage|g" \
		|| die
}

src_configure() {
	GOFLAGS+=" -tags=netgo,osusergo,static_build,kvformat"
}

src_compile() {
	local myargs=(
		-trimpath
		-ldflags "-X main.Version=${PV}"
	)

	ego build "${myargs[@]}" ./cmd/gotosocial
}

src_test() {
	local -x GTS_DB_TYPE="sqlite"
	local -x GTS_DB_ADDRESS=":memory:"

	local -x GOFLAGS
	GOFLAGS="${GOFLAGS//-v/}"
	GOFLAGS="${GOFLAGS//-x/}"

	ego test -vet off ./...
}

src_install() {
	dobin gotosocial

	newinitd "${FILESDIR}"/gotosocial.initd ${PN}
	newconfd "${FILESDIR}"/gotosocial.confd ${PN}
	systemd_dounit "${FILESDIR}"/gotosocial.service
	newtmpfiles "${FILESDIR}"/gotosocial.tmpfiles ${PN}.conf

	insinto /usr/share/gotosocial
	doins -r web

	insinto /etc/gotosocial
	doins example/config.yaml
}

pkg_postinst() {
	tmpfiles_process ${PN}.conf
}
