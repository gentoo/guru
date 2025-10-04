# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Incus web UI module"
HOMEPAGE="https://github.com/zabbly/incus-ui-canonical"

SRC_URI="
	https://github.com/zabbly/incus-ui-canonical/archive/refs/tags/incus-0.18.2.tar.gz -> ${P}.tar.gz
	https://github.com/AdelKS/gentoo-distfiles/releases/download/${CATEGORY}/${PF}/${PF}-deps.tar.xz
"

S="${WORKDIR}/incus-ui-canonical-incus-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-containers/incus
	net-libs/nodejs[npm]
"
DEPEND="${RDEPEND}"
BDEPEND="
	net-libs/nodejs[npm]
	sys-apps/yarn
"

src_prepare() {
	default
	unpack "${PF}-deps.tar.xz"
	yarn install || die
}

src_compile() {
	yarn build || die
}

src_install() {
	insinto /usr/share/incus-ui
	doins -r build/ui/*

	systemd_install_dropin incus.service "${FILESDIR}"/incus.systemd.override
}

pkg_postinst() {
	systemctl daemon-reload
}

pkg_postrm() {
	systemctl daemon-reload
}
