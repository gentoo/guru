# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module linux-info systemd

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="https://yggdrasil-network.github.io/"
LICENSE="LGPL-3 MIT Apache-2.0 BSD ZLIB"

EGO_SUM=(
	"github.com/Arceliar/phony v0.0.0-20191006174943-d0c68492aca0"
	"github.com/Arceliar/phony v0.0.0-20191006174943-d0c68492aca0/go.mod"
	"github.com/VividCortex/ewma v1.1.1"
	"github.com/VividCortex/ewma v1.1.1/go.mod"
	"github.com/cheggaaa/pb/v3 v3.0.4"
	"github.com/cheggaaa/pb/v3 v3.0.4/go.mod"
	"github.com/fatih/color v1.7.0"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/gologme/log v0.0.0-20181207131047-4e5d8ccb38e8"
	"github.com/gologme/log v0.0.0-20181207131047-4e5d8ccb38e8/go.mod"
	"github.com/hashicorp/go-syslog v1.0.0"
	"github.com/hashicorp/go-syslog v1.0.0/go.mod"
	"github.com/hjson/hjson-go v3.0.1-0.20190209023717-9147687966d9+incompatible"
	"github.com/hjson/hjson-go v3.0.1-0.20190209023717-9147687966d9+incompatible/go.mod"
	"github.com/kardianos/minwinsvc v0.0.0-20151122163309-cad6b2b879b0"
	"github.com/kardianos/minwinsvc v0.0.0-20151122163309-cad6b2b879b0/go.mod"
	"github.com/lxn/walk v0.0.0-20191128110447-55ccb3a9f5c1"
	"github.com/lxn/walk v0.0.0-20191128110447-55ccb3a9f5c1/go.mod"
	"github.com/lxn/win v0.0.0-20191128105842-2da648fda5b4"
	"github.com/lxn/win v0.0.0-20191128105842-2da648fda5b4/go.mod"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-colorable v0.1.2/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.10"
	"github.com/mattn/go-isatty v0.0.10/go.mod"
	"github.com/mattn/go-runewidth v0.0.7"
	"github.com/mattn/go-runewidth v0.0.7/go.mod"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/mitchellh/mapstructure v1.1.2/go.mod"
	"github.com/vishvananda/netlink v1.0.0"
	"github.com/vishvananda/netlink v1.0.0/go.mod"
	"github.com/vishvananda/netns v0.0.0-20190625233234-7109fa855b0f"
	"github.com/vishvananda/netns v0.0.0-20190625233234-7109fa855b0f/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191002192127-34f69633bfdc/go.mod"
	"golang.org/x/crypto v0.0.0-20200221231518-2aa609cf4a9d"
	"golang.org/x/crypto v0.0.0-20200221231518-2aa609cf4a9d/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20191003171128-d98b1b443823/go.mod"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190904154756-749cb33beabd/go.mod"
	"golang.org/x/sys v0.0.0-20191003212358-c178f38b412c/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191128015809-6d18c012aee9/go.mod"
	"golang.org/x/sys v0.0.0-20200301040627-c5d0d7b4ec88/go.mod"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/text v0.3.3-0.20191230102452-929e72ca90de"
	"golang.org/x/text v0.3.3-0.20191230102452-929e72ca90de/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.zx2c4.com/wireguard v0.0.20200122-0.20200214175355-9cbcff10dd3e/go.mod"
	"golang.zx2c4.com/wireguard v0.0.20200320"
	"golang.zx2c4.com/wireguard v0.0.20200320/go.mod"
	"golang.zx2c4.com/wireguard/windows v0.1.0"
	"golang.zx2c4.com/wireguard/windows v0.1.0/go.mod"
	)
go-module_set_globals

SRC_URI="https://github.com/yggdrasil-network/yggdrasil-go/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-vcs/git-1.7.3"
BDEPEND=">=dev-lang/go-1.13"

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
	PKGNAME="${PN}-${PV}" PKGVER="v${PV}" ./build
}

src_install() {
	dobin {yggdrasil,yggdrasilctl}
	dodoc README.md

	systemd_dounit "contrib/systemd/yggdrasil.service"
	newinitd "contrib/openrc/yggdrasil" yggdrasil
}
