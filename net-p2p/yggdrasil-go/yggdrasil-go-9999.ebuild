# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps go-module linux-info systemd

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="https://yggdrasil-network.github.io/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/yggdrasil-network/yggdrasil-go"
	inherit git-r3
else
	SRC_URI="
		https://github.com/yggdrasil-network/yggdrasil-go/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://codeberg.org/BratishkaErik/distfiles/releases/download/yggdrasil-go-${PV}/yggdrasil-go-${PV}-vendor.tar.xz
	"
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="LGPL-3 MIT Apache-2.0 BSD ZLIB"
SLOT="0"

RESTRICT="mirror"

BDEPEND=">=dev-lang/go-1.23"
DEPEND="
	acct-user/yggdrasil
	acct-group/yggdrasil
"

DOCS=( "README.md" "CHANGELOG.md" )

FILECAPS=(
	cap_net_admin,cap_net_bind_service "usr/bin/yggdrasil"
)

CONFIG_CHECK="~TUN"
ERROR_TUN="Your kernel lacks TUN support."

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	fi
	go-module_src_unpack
}

src_compile() {
	GOFLAGS+=" -mod=vendor -trimpath"

	local src="github.com/yggdrasil-network/yggdrasil-go/src/version"
	local name version
	if [[ ${PV} == 9999 ]]; then
		chmod +x ./contrib/semver/{name,version}.sh || die
		name="$(./contrib/semver/name.sh || die)"
		version="$(./contrib/semver/version.sh || die)"
	else
		name="yggdrasil"
		version="v${PV}"
	fi
	local custom_name_version_flags="-X ${src}.buildName=${name} -X ${src}.buildVersion=${version}"

	local go_ldflags="-s -linkmode external -extldflags \"${LDFLAGS}\" ${custom_name_version_flags}"

	for cmd in yggdrasil{,ctl}; do
		ego build ${GOFLAGS} -ldflags="${go_ldflags}" ./cmd/${cmd}
	done
}

src_install() {
	dobin yggdrasil{,ctl}
	einstalldocs

	systemd_dounit "contrib/systemd/yggdrasil.service"
	systemd_dounit "contrib/systemd/yggdrasil-default-config.service"
	doinitd "contrib/openrc/yggdrasil"
}
