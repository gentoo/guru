# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1 readme.gentoo-r1 systemd tmpfiles

DESCRIPTION="‎Modern, responsive, cross-platform, self-hosted web IRC client"
HOMEPAGE="https://thelounge.chat/"

SRC_URI="
	https://github.com/thelounge/thelounge/archive/refs/tags/v${PV/_rc/-rc.}.tar.gz -> ${P}.tar.gz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/deps.tar.xz -> ${P}-deps.tar.xz
	sqlite? ( https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/sqlite.tar.xz -> ${P}-sqlite.tar.xz )
"

S="${WORKDIR}/${PN}-${PV/_rc/-rc.}"
LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sqlite"

RDEPEND="
	acct-user/${PN}
	acct-group/${PN}
	>=net-libs/nodejs-16
	sqlite? ( dev-db/sqlite:3= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sqlite? ( ${PYTHON_DEPS} )
	>=net-libs/nodejs-16[npm]
	sys-apps/yarn
"

DOC_CONTENTS="\n
##### Defaults #####\n
Data directory: /var/lib/${PN}\n
Listens on: 0.0.0.0:9000\n
Log file (openrc): /var/log/${PN}.log\n
Config file: /var/lib/${PN}/config.js\n
\n
##### Initialization #####\n
Run \`THELOUNGE_HOME=/var/lib/${PN} ${PN} add <user>\`
"

mooyarn() {
	use !sqlite && local YARN_OPTS="--ignore-optional"
	yarn --verbose  --non-interactive --frozen-lockfile --cache-folder "${WORKDIR}"/yarn-cache --offline \
		 --ignore-scripts ${YARN_OPTS} "${@}" || die
}

pkg_setup() {
	use sqlite && python-any-r1_pkg_setup
}

src_prepare() {
	default
	use !sqlite && { sed -i -e 's|\["sqlite", |\[|g;' defaults/config.js  || die ; }

}
src_compile() {
	# thelounge build
	mooyarn install
	NODE_ENV=production mooyarn build
	local BUILT_TAR=$(realpath $(npm pack || die))
	# thelounge install
	mkdir -v moobuild && cp -v {package.json,yarn.lock} moobuild/ || die
	pushd moobuild || die
	NODE_ENV=production mooyarn add file:${BUILT_TAR:?}

	if use sqlite; then
		# sqlite3 build
		pushd node_modules/sqlite3 || die
		export \
			npm_config_cache="${WORKDIR}"/npm-cache \
			npm_config_nodedir="${EPREFIX}"/usr \
			NODE_GYP_FORCE_PYTHON="${PYTHON}" \
			|| die
		npm --verbose --offline install --build-from-source --sqlite="${EPREFIX}"/usr || die
		# sqlite3 cleanup
		rm -rf node_modules || die
		find build* -type f -not -path build/Release/node_sqlite3.node -delete || die
		popd || die
	fi
	popd || die

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
