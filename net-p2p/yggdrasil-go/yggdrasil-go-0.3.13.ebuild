# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/yggdrasil-network/yggdrasil-go"
EGO_VENDOR=(
	"github.com/Arceliar/phony d0c68492aca0"
	"github.com/gologme/log 4e5d8ccb38e8"
	"github.com/hashicorp/go-syslog v1.0.0"
	"github.com/hjson/hjson-go v3.0.1"
	"github.com/kardianos/minwinsvc cad6b2b879b0"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/vishvananda/netlink v1.0.0"
	"github.com/vishvananda/netns 7109fa855b0f"
	"golang.org/x/crypto 53104e6ec876 github.com/golang/crypto"
	"golang.org/x/net c0dbc17a3553 github.com/golang/net"
	"golang.org/x/sys a1369afcdac7 github.com/golang/sys"
	"golang.org/x/text v0.3.2 github.com/golang/text"
	"golang.zx2c4.com/wireguard v0.0.20200121 github.com/WireGuard/wireguard-go"
	"golang.zx2c4.com/wireguard/windows cb4a03094c25 github.com/WireGuard/wireguard-windows"
)

inherit golang-vcs-snapshot linux-info systemd

SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="https://yggdrasil-network.github.io/"
LICENSE="LGPL-3"

SLOT="0"
IUSE=""
KEYWORDS="~amd64"

QA_PRESTRIPPED="/usr/bin/yggdrasil /usr/bin/yggdrasilctl"

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
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x -ldflags "\
		-X ${EGO_PN}/src/yggdrasil.buildName=yggdrasil \
		-X ${EGO_PN}/src/yggdrasil.buildVersion=${PV} \
		-s -w" \
		${EGO_PN}/cmd/... || die
}

src_install() {
	dobin bin/*

	systemd_dounit "src/${EGO_PN}/contrib/systemd/yggdrasil.service"
	newinitd "src/${EGO_PN}/contrib/openrc/yggdrasil" yggdrasil
}
