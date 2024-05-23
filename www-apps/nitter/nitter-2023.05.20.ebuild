# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble systemd

COMMIT="e3b3b38a2d43a83b5fc2239ab41e864ee686fb2f"
DESCRIPTION="Alternative front-end for Twitter"
HOMEPAGE="https://github.com/zedeus/nitter"
SRC_URI="https://github.com/zedeus/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="
	acct-user/nitter
	dev-db/redis
"
DEPEND="
	dev-nim/flatty
	dev-nim/jester
	dev-nim/jsony
	dev-nim/karax
	dev-nim/markdown
	dev-nim/nimcrypto
	dev-nim/packedjson
	dev-nim/redpool
	dev-nim/sass
	dev-nim/supersnappy
	dev-nim/zedeus_redis
	dev-nim/zippy
"

src_configure() {
	nimble_src_configure

	# Error: unhandled exception: cannot open: public/lp.svg
	ln -s "${S}"/public "${BUILD_DIR}/public" || die
}

src_compile() {
	nimble_src_compile
	enim r tools/gencss
	enim r tools/rendermd
}

src_install() {
	nimble_src_install

	newinitd "${FILESDIR}"/nitter.initd ${PN}
	systemd_dounit "${FILESDIR}"/nitter.service

	insinto /etc/nitter
	doins "${FILESDIR}"/nitter.conf.example

	insinto /usr/share/nitter
	doins -r public
}
