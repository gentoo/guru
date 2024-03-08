# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1 systemd tmpfiles

DESCRIPTION="‎Modern, responsive, cross-platform, self-hosted web IRC client"
HOMEPAGE="https://thelounge.chat/"

SRC_URI="
	https://github.com/thelounge/thelounge/archive/refs/tags/v${PV/_rc/-rc.}.tar.gz -> ${P}.tar.gz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/deps.tar.xz -> ${P}-deps.tar.xz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/sqlite3.tar.xz -> ${P}-sqlite3.tar.xz
"

S="${WORKDIR}/${PN}-${PV/_rc/-rc.}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/${PN}
	acct-group/${PN}
	>=net-libs/nodejs-18
"
BDEPEND="
	>=net-libs/nodejs-18[npm]
	sys-apps/yarn
"

DOC_CONTENTS="\n
##### Defaults #####\n
Data directory: /var/lib/${PN}\n
Listens on: 0.0.0.0:9000\n
Log file (openrc): /var/log/${PN}.log\n
\n
##### Initialization #####\n
Run \`THELOUNGE_HOME=/var/lib/${PN} ${PN} add <user>\`
"

mooyarn() {
	yarn --verbose  --non-interactive --frozen-lockfile --cache-folder ../yarn-cache \
		 --offline --global-folder moobuild "${@}" || die
}

src_compile() {
	mooyarn install
	NODE_ENV=production mooyarn build
	local BUILT_TAR=$(npm pack)
	NODE_ENV=production mooyarn global add file:$(realpath ${BUILT_TAR})

	# this workaround because sqlite3 module requires network access
	mv -v ../sqlite3 moobuild/node_modules/ || die
}

src_install() {
	insinto /usr/$(get_libdir)/node_modules/"${PN}"
	doins -r moobuild/node_modules

	fperms 755 /usr/$(get_libdir)/node_modules/"${PN}"/node_modules/"${PN}"/index.js
	dosym -r /usr/$(get_libdir)/node_modules/"${PN}"/node_modules/"${PN}"/index.js /usr/bin/"${PN}"

	systemd_newunit "${FILESDIR}"/"${PN}"-4.4.1.service "${PN}".service
	systemd_newuserunit "${FILESDIR}"/"${PN}"-4.4.1-user.service "${PN}".service
	newinitd "${FILESDIR}"/"${PN}"-4.4.1.initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}"-4.4.1.confd "${PN}"
	newtmpfiles "${FILESDIR}"/"${PN}"-4.4.1-tmpfiles.conf "${PN}".conf
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/"${PN}"-4.4.1.logrotate "${PN}"

	readme.gentoo_create_doc
}

pkg_postinst() {
	tmpfiles_process "${PN}".conf
	readme.gentoo_print_elog
}
