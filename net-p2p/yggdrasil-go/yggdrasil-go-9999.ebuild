# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps git-r3 go-module linux-info systemd

EGIT_REPO_URI="https://github.com/yggdrasil-network/yggdrasil-go"

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="https://yggdrasil-network.github.io/"

LICENSE="LGPL-3 MIT Apache-2.0 BSD ZLIB"
SLOT="0"

DEPEND="
	acct-user/yggdrasil
	acct-group/yggdrasil
"

BDEPEND=">=dev-lang/go-1.21"

DOCS=( README.md CHANGELOG.md )

FILECAPS=(
	cap_net_admin,cap_net_bind_service "usr/bin/yggdrasil"
)

CONFIG_CHECK="~TUN"
ERROR_TUN="Your kernel lacks TUN support."

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	GOFLAGS+=" -mod=vendor -trimpath"

	local ver_config="github.com/yggdrasil-network/yggdrasil-go/src/version"

	local custom_name_version_flags="-X ${ver_config}.buildName=${PN}"
	custom_name_version_flags+=" -X ${ver_config}.buildVersion=git-${EGIT_VERSION}"

	local GO_LDFLAGS
	GO_LDFLAGS="-s -linkmode external -extldflags \"${LDFLAGS}\" ${custom_name_version_flags}"

	local cmd
	for cmd in yggdrasil{,ctl}; do
		ego build ${GOFLAGS} "-ldflags=${GO_LDFLAGS}" ./cmd/"${cmd}"
	done
}

src_install() {
	dobin yggdrasil{,ctl}
	einstalldocs

	systemd_dounit "contrib/systemd/yggdrasil.service"
	systemd_dounit "contrib/systemd/yggdrasil-default-config.service"
	doinitd "contrib/openrc/yggdrasil"
}
