# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="ActivityPub server with minimal setup and support costs"
HOMEPAGE="https://humungus.tedunangst.com/r/honk"
SRC_URI="https://humungus.tedunangst.com/r/${PN}/d/${P}.tgz"

LICENSE="BSD BSD-2 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-db/sqlite:3"
RDEPEND="
	${DEPEND}
	acct-user/honk
"

DOCS=( README docs/{changelog,ping}.txt docs/{intro.1,vim.3} )

src_install() {
	dobin honk
	doman docs/activitypub.7 docs/hfcs.1 docs/honk.{1,3,5,8}
	einstalldocs

	doinitd "${FILESDIR}"/honk
	systemd_dounit "${FILESDIR}"/honk.service

	insinto /usr/share/honk
	doins -r views

	diropts --owner honk --group honk
	keepdir /var/lib/honk
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		einfo "To finish the installation, please run:"
		einfo "	# rc-service honk init"
	else
		einfo "To finish the upgrade, please run:"
		einfo "	# rc-service honk upgrade"
	fi
}
