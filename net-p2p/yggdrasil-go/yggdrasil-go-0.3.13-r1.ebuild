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
	"github.com/gologme/log v0.0.0-20181207131047-4e5d8ccb38e8"
	"github.com/gologme/log v0.0.0-20181207131047-4e5d8ccb38e8/go.mod"
	"github.com/hashicorp/go-syslog v1.0.0"
	"github.com/hashicorp/go-syslog v1.0.0/go.mod"
	"github.com/hjson/hjson-go v3.0.1-0.20190209023717-9147687966d9+incompatible"
	"github.com/hjson/hjson-go v3.0.1-0.20190209023717-9147687966d9+incompatible/go.mod"
	"github.com/kardianos/minwinsvc v0.0.0-20151122163309-cad6b2b879b0"
	"github.com/kardianos/minwinsvc v0.0.0-20151122163309-cad6b2b879b0/go.mod"
	"github.com/lxn/walk v0.0.0-20191031081659-c0bb82ae46cb/go.mod"
	"github.com/lxn/win v0.0.0-20191024121223-cc00c7492fe1"
	"github.com/lxn/win v0.0.0-20191024121223-cc00c7492fe1/go.mod"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/mitchellh/mapstructure v1.1.2/go.mod"
	"github.com/vishvananda/netlink v1.0.0"
	"github.com/vishvananda/netlink v1.0.0/go.mod"
	"github.com/vishvananda/netns v0.0.0-20190625233234-7109fa855b0f"
	"github.com/vishvananda/netns v0.0.0-20190625233234-7109fa855b0f/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191002192127-34f69633bfdc/go.mod"
	"golang.org/x/crypto v0.0.0-20191029031824-8986dd9e96cf/go.mod"
	"golang.org/x/crypto v0.0.0-20191227163750-53104e6ec876"
	"golang.org/x/crypto v0.0.0-20191227163750-53104e6ec876/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20191003171128-d98b1b443823/go.mod"
	"golang.org/x/net v0.0.0-20191028085509-fe3aa8a45271/go.mod"
	"golang.org/x/net v0.0.0-20191209160850-c0dbc17a3553"
	"golang.org/x/net v0.0.0-20191209160850-c0dbc17a3553/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190904154756-749cb33beabd/go.mod"
	"golang.org/x/sys v0.0.0-20191003212358-c178f38b412c/go.mod"
	"golang.org/x/sys v0.0.0-20191029155521-f43be2a4598c/go.mod"
	"golang.org/x/sys v0.0.0-20200103143344-a1369afcdac7"
	"golang.org/x/sys v0.0.0-20200103143344-a1369afcdac7/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.zx2c4.com/wireguard v0.0.20191013-0.20191030132932-4cdf805b29b1"
	"golang.zx2c4.com/wireguard v0.0.20191013-0.20191030132932-4cdf805b29b1/go.mod"
	"golang.zx2c4.com/wireguard v0.0.20200121"
	"golang.zx2c4.com/wireguard v0.0.20200121/go.mod"
	"golang.zx2c4.com/wireguard/windows v0.0.35-0.20191123133119-cb4a03094c25"
	"golang.zx2c4.com/wireguard/windows v0.0.35-0.20191123133119-cb4a03094c25/go.mod"
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
