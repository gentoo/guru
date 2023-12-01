# Copyright 2016-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps go-module tmpfiles systemd flag-o-matic

MY_PV="$(ver_cut 1-3)-$(ver_cut 4)"
DESCRIPTION="A self-hosted lightweight software forge"
HOMEPAGE="https://forgejo.org/ https://codeberg.org/forgejo/forgejo"

SRC_URI="https://codeberg.org/forgejo/forgejo/releases/download/v${MY_PV}/forgejo-src-${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
S="${WORKDIR}/${PN}-src-${MY_PV}"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
IUSE="+acct pam sqlite pie"

DEPEND="
	acct? (
		acct-group/git
		acct-user/git[gitea] )
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND}
	dev-vcs/git
	!www-apps/gitea" # until acct-user/git[forgejo]

DOCS=(
	custom/conf/app.example.ini CONTRIBUTING.md README.md
)
FILECAPS=(
	-m 711 cap_net_bind_service+ep usr/bin/forgejo
)

RESTRICT="test"

src_prepare() {
	default

	local sedcmds=(
		-e "s#^ROOT =#ROOT = ${EPREFIX}/var/lib/gitea/gitea-repositories#"
		-e "s#^ROOT_PATH =#ROOT_PATH = ${EPREFIX}/var/log/forgejo#"
		-e "s#^APP_DATA_PATH = data#APP_DATA_PATH = ${EPREFIX}/var/lib/gitea/data#"
		-e "s#^HTTP_ADDR = 0.0.0.0#HTTP_ADDR = 127.0.0.1#"
		-e "s#^MODE = console#MODE = file#"
		-e "s#^LEVEL = Trace#LEVEL = Info#"
		-e "s#^LOG_SQL = true#LOG_SQL = false#"
		-e "s#^DISABLE_ROUTER_LOG = false#DISABLE_ROUTER_LOG = true#"
	)

	sed -i "${sedcmds[@]}" custom/conf/app.example.ini || die
	if use sqlite ; then
		sed -i -e "s#^DB_TYPE = .*#DB_TYPE = sqlite3#" custom/conf/app.example.ini || die
	fi
}

src_configure() {
	# bug 832756 - PIE build issues
	filter-flags -fPIE
	filter-ldflags -fPIE -pie
}

src_compile() {
	local forgejo_tags=(
		bindata
		$(usev pam)
		$(usex sqlite 'sqlite sqlite_unlock_notify' '')
	)
	local forgejo_settings=(
		"-X code.gitea.io/gitea/modules/setting.CustomConf=${EPREFIX}/etc/forgejo/app.ini"
		"-X code.gitea.io/gitea/modules/setting.CustomPath=${EPREFIX}/var/lib/gitea/custom"
		"-X code.gitea.io/gitea/modules/setting.AppWorkPath=${EPREFIX}/var/lib/gitea"
	)
	local makeenv=(
		DRONE_TAG="${PV}"
		LDFLAGS="-extldflags \"${LDFLAGS}\" ${forgejo_settings[*]}"
		TAGS="${forgejo_tags[*]}"
	)

	GOFLAGS=""
	if use pie ; then
		GOFLAGS+="-buildmode=pie"
	fi

	# need to set -j1 or build fails due to a race condition between MAKE jobs.
	# this does not actually impact build parallelism, because the go compiler
	# will still build everything in parallel when it's invoked.
	env "${makeenv[@]}" emake -j1 EXTRA_GOFLAGS="${GOFLAGS}" backend
}

src_install() {
	cp gitea forgejo
	dobin forgejo

	einstalldocs

	newconfd "${FILESDIR}/forgejo.confd-r1" forgejo
	newinitd "${FILESDIR}/forgejo.initd-r3" forgejo
	newtmpfiles - forgejo.conf <<-EOF
		d /run/forgejo 0755 git git
	EOF
	systemd_newunit "${FILESDIR}"/forgejo.service-r3 forgejo.service

	insinto /etc/forgejo
	newins custom/conf/app.example.ini app.ini
	if use acct; then
		fowners root:git /etc/forgejo/{,app.ini}
		fperms g+w,o-rwx /etc/forgejo/{,app.ini}

		diropts -m0750 -o git -g git
		keepdir /var/lib/gitea /var/lib/gitea/custom /var/lib/gitea/data
		keepdir /var/log/forgejo
	fi
}

pkg_postinst() {
	fcaps_pkg_postinst
	tmpfiles_process forgejo.conf

	ewarn "${PN} ${MY_PV} will continue to use /var/lib/gitea as the default home,"
	ewarn "as acct-user/git[gitea] depends on it, and acct-user[forgejo] does not"
	ewarn "exist yet."
}
