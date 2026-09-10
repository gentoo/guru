# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Incus web UI module"
HOMEPAGE="https://github.com/zabbly/incus-ui-canonical"

# how to obtain the deps tarball: .git needs to be bundled for the install to work to work without web-fetching stuff
#   PV=0.21.5
#   git clone https://github.com/zabbly/incus-ui-canonical.git --branch incus-${PV} --depth 1 incus-ui-canonical && \
#   cd incus-ui-canonical && yarn install && \
#   rm -rf .git/{logs,index,hooks,description,info} && \
#   tar caf ../incus-ui-${PV}-deps.tar.xz --owner=0 --group=0 --numeric-owner node_modules .git

SRC_URI="
	https://github.com/zabbly/incus-ui-canonical/archive/refs/tags/incus-${PV}.tar.gz -> ${P}.tar.gz
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
	dev-vcs/git
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

  # for openrc
	newenvd "${FILESDIR}"/90incus-ui.openrc.env 90incus-ui

	# for systemd
	systemd_install_dropin incus.service "${FILESDIR}"/incus.systemd.override
}
