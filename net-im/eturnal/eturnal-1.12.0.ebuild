# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rebar3 systemd

DESCRIPTION="STUN/TURN server"
HOMEPAGE="
	https://eturnal.net/
	https://github.com/processone/eturnal
"
SRC_URI="https://eturnal.net/download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-user/eturnal
	>=dev-lang/erlang-21[ssl]
	dev-libs/libyaml
	dev-libs/openssl:=
	>=dev-erlang/conf-0.1
	dev-erlang/fast_tls
	dev-erlang/fast_yaml
	dev-erlang/p1_utils
	>=dev-erlang/stun-1.2
	dev-erlang/yval
"
RDEPEND="${DEPEND}"

DOCS=( {CHANGELOG,README}.md doc/. )

REBAR_PROFILE=distro

src_configure() {
	export ETURNAL_USER=eturnal
	export ETURNAL_PREFIX="${EPREFIX}"/opt/eturnal
	export ETURNAL_ETC_DIR="${EPREFIX}"/etc
	export ERL_EPMD_ADDRESS=""
	export CODE_LOADING=dynamic

	export SKIP_DEPS=true

	rebar3_src_configure
}

rebar3_install_release() {
	mkdir -p "${ED}"/opt/eturnal || die
	cp -pR bin lib releases "${ED}"/opt/eturnal/ || die

	systemd_dounit etc/systemd/system/eturnal.service
	newinitd etc/openrc/eturnal.initd eturnal
	newconfd etc/openrc/eturnal.confd eturnal

	insinto /etc
	doins etc/eturnal.yml
	doins -r etc/logrotate.d

	keepdir /opt/eturnal/{log,run}
	fowners eturnal:turnserver /opt/eturnal/{log,run}

	dosym -r /opt/eturnal/bin/eturnalctl /usr/sbin/eturnalctl
}
