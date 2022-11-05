# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module linux-info systemd fcaps

DESCRIPTION="Popura: alternative Yggdrasil network client"
HOMEPAGE="https://github.com/popura-network/Popura/"
SRC_URI="
	https://github.com/popura-network/Popura/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/popura-network/Popura/releases/download/v${PV}/popura-${PV}-vendor.tar.xz
"

LICENSE="LGPL-3 MPL-2.0 MIT Apache-2.0 BSD ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-user/yggdrasil
	acct-group/yggdrasil
"

BDEPEND=">=dev-lang/go-1.17.0"
RDEPEND="!net-p2p/yggdrasil-go"

S="${WORKDIR}/Popura-${PV}"

FILECAPS=(
	cap_net_admin,cap_net_bind_service "usr/bin/yggdrasil"
)

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists; then
		eerror "Unable to check your kernel for TUN support"
	else
		CONFIG_CHECK="~TUN"
		ERROR_TUN="Your kernel lacks TUN support."
	fi
}

src_compile() {
	local package="github.com/yggdrasil-network/yggdrasil-go/src/version"

	for CMD in yggdrasil yggdrasilctl ; do
		ego build -buildmode=pie -ldflags "-s -linkmode external -extldflags '${LDFLAGS}' -X ${package}.buildName=${PN} -X ${package}.buildVersion=v${PV}" -trimpath ./cmd/$CMD
	done
}

src_install() {
	dobin {yggdrasil,yggdrasilctl}
	dodoc README.md
	systemd_dounit "contrib/systemd/yggdrasil.service"
	systemd_dounit "contrib/systemd/yggdrasil-default-config.service"
	doinitd "contrib/openrc/yggdrasil"
}
