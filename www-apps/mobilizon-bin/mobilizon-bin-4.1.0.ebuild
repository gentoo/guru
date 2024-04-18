# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature systemd

MY_PN=${PN%-bin}
DESCRIPTION="Online tool to help manage your events, your profiles and your groups"
HOMEPAGE="https://joinmobilizon.org/"
SRC_URI="https://packages.joinmobilizon.org/${PV}/${MY_PN}_${PV}_amd64-fedora-39.tar.gz"
S="${WORKDIR}/${MY_PN}"

# TODO: add licenses for bundled deps (I'm not in mood)
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	acct-user/mobilizon
	dev-db/postgis
	dev-db/postgresql:*
	>=dev-libs/openssl-3
	sys-libs/ncurses[tinfo]
	virtual/imagemagick-tools
	virtual/mta
"

QA_PREBUILT=".*"

src_install() {
	local destdir="${ED}/opt/mobilizon"

	mkdir -p "${destdir}"
	cp -pPR "${S}"/* "${destdir}"

	dosym -r {/opt/mobilizon/bin,/usr/sbin}/mobilizon
	dosym -r {/opt/mobilizon/bin,usr/sbin}/mobilizon_ctl

	fowners -R mobilizon:mobilizon /opt/mobilizon
	diropts -o mobilizon -g mobilizon
	keepdir /var/lib/mobilizon/{uploads/exports/csv,data}
	keepdir /etc/mobilizon

	newinitd "${FILESDIR}"/mobilizon.initd mobilizon
	systemd_newunit support/systemd/mobilizon-release.service mobilizon.service
}

pkg_postinst() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		einfo "To finish the installation, run:"
		einfo "#	rc-service mobilizon init"
	else
		einfo "Remember to execute database migrations:"
		einfo "#	rc-service mobilizon upgrade"
	fi

	optfeature "image optimization support" \
		media-gfx/gifsicle \
		media-gfx/jpegoptim \
		media-gfx/optipng \
		media-gfx/pngquant
}
