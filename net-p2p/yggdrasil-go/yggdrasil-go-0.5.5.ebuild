# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps go-module linux-info systemd

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="https://yggdrasil-network.github.io/"
SRC_URI="
	https://github.com/yggdrasil-network/yggdrasil-go/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/BratishkaErik/distfiles/releases/download/${P}/vendor.tar.xz -> ${P}-vendor.tar.xz
"

LICENSE="LGPL-3 MIT Apache-2.0 BSD ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="
	acct-user/yggdrasil
	acct-group/yggdrasil
"

BDEPEND=">=dev-lang/go-1.20.0"

FILECAPS=(
	cap_net_admin,cap_net_bind_service "usr/bin/yggdrasil"
)

CONFIG_CHECK="~TUN"
ERROR_TUN="Your kernel lacks TUN support."

src_compile() {
	local ver_config="github.com/yggdrasil-network/yggdrasil-go/src/version"

	local version_disable_detect_flags="-X ${ver_config}.buildName=${PN}"
	version_disable_detect_flags+=" -X ${ver_config}.buildVersion=v${PV}"

	GOFLAGS+=" -mod=vendor -trimpath"

	local GO_LDFLAGS
	GO_LDFLAGS="-s -linkmode external -extldflags \"${LDFLAGS}\" ${version_disable_detect_flags}"

	local cmd
	for cmd in yggdrasil{,ctl}; do
		ego build ${GOFLAGS} "-ldflags=${GO_LDFLAGS}" ./cmd/"${cmd}"
	done
}

src_install() {
	dobin yggdrasil{,ctl}
	dodoc README.md
	dodoc CHANGELOG.md

	systemd_dounit "contrib/systemd/yggdrasil.service"
	systemd_dounit "contrib/systemd/yggdrasil-default-config.service"
	doinitd "contrib/openrc/yggdrasil"
}
