# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-render-swagger-plugin"
PYTHON_COMPAT=( python3_{8..11} )
inherit python-any-r1 docs go-module systemd tmpfiles

DESCRIPTION="Fast, fun, ActivityPub server, powered by Go"
HOMEPAGE="
	https://gotosocial.org/
	https://github.com/superseriousbusiness/gotosocial
"
GH="https://github.com/superseriousbusiness/${PN}"
SRC_URI="
	${GH}/releases/download/v${PV}/${P}-source-code.tar.gz
	${GH}/releases/download/v${PV}/${PN}_${PV}_web-assets.tar.gz
"
S="${WORKDIR}"

LICENSE="|| ( WTFPL CC0-1.0 ) AGPL-3 BSD BSD-2 CC0-1.0 GPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="acct-user/gotosocial"

DOCS=( archive {CONTRIBUTING,README,ROADMAP}.md )

src_unpack() {
	# source code
	unpack ${P}-source-code.tar.gz
	rm -r web || die

	# prebuilt web assets
	unpack ${PN}_${PV}_web-assets.tar.gz
}

src_compile() {
	local myargs=(
		-trimpath
		-ldflags "-X main.Version=${PV}"
		-tags netgo,osusergo,static_build,kvformat
	)

	local -x CGO_ENABLED=0
	ego build "${myargs[@]}" ./cmd/gotosocial

	use doc && docs_compile
}

src_test() {
	local -x GTS_DB_TYPE="sqlite"
	local -x GTS_DB_ADDRESS=":memory:"
	local -x CGO_ENABLED=0

	local myargs=(
		-tags netgo,osusergo,static_build,kvformat
		-count 1
	)
	ego test "${myargs[@]}" ./...
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
	doins "${FILESDIR}"/config.yaml
}

pkg_postinst() {
	tmpfiles_process ${PN}.conf
}
