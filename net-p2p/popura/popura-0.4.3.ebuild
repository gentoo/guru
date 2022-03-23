# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module linux-info systemd

DESCRIPTION="Popura: alternative Yggdrasil network client"
HOMEPAGE="https://github.com/popura-network/Popura/"
DOCS=( README.md )

KEYWORDS="~amd64"
SRC_URI="
	https://github.com/popura-network/Popura/archive/v${PV}+popura1.tar.gz -> ${P}+popura1.tar.gz
	https://gitea.minecast.xyz/BratishkaErik/distfiles/media/branch/master/${P}+popura1-deps.tar.bz2
"

S="${WORKDIR}/Popura-${PV}-popura1"

LICENSE="LGPL-3 MPL-2.0 MIT Apache-2.0 BSD ZLIB"
SLOT="0"

DEPEND="
	acct-user/yggdrasil
	acct-group/yggdrasil
"

RDEPEND="!!net-p2p/yggdrasil-go"

BDEPEND=">=dev-lang/go-1.16.0"

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
	PKGNAME="${PN}" PKGVER="${PV}+popura1" \
	GOFLAGS="-trimpath -buildmode=pie -mod=readonly" \
	./build -l "-linkmode external -extldflags \"${LDFLAGS}\""
}

src_install() {
	dobin {yggdrasil,yggdrasilctl}
	systemd_dounit "contrib/systemd/yggdrasil.service"
	systemd_dounit "contrib/systemd/yggdrasil-default-config.service"
	doinitd "contrib/openrc/yggdrasil"
}
