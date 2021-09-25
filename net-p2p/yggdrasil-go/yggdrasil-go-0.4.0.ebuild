# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module linux-info systemd

EGO_SUM=(
"github.com/Arceliar/ironwood v0.0.0-20210619124114-6ad55cae5031"
"github.com/Arceliar/ironwood v0.0.0-20210619124114-6ad55cae5031/go.mod"
"github.com/Arceliar/phony v0.0.0-20210209235338-dde1a8dca979"
"github.com/Arceliar/phony v0.0.0-20210209235338-dde1a8dca979/go.mod"
"github.com/VividCortex/ewma v1.1.1/go.mod"
"github.com/VividCortex/ewma v1.2.0"
"github.com/VividCortex/ewma v1.2.0/go.mod"
"github.com/cheggaaa/pb/v3 v3.0.8"
"github.com/cheggaaa/pb/v3 v3.0.8/go.mod"
"github.com/fatih/color v1.10.0/go.mod"
"github.com/fatih/color v1.12.0"
"github.com/fatih/color v1.12.0/go.mod"
"github.com/gologme/log v1.2.0"
"github.com/gologme/log v1.2.0/go.mod"
"github.com/hashicorp/go-syslog v1.0.0"
"github.com/hashicorp/go-syslog v1.0.0/go.mod"
"github.com/hjson/hjson-go v3.1.0+incompatible"
"github.com/hjson/hjson-go v3.1.0+incompatible/go.mod"
"github.com/kardianos/minwinsvc v1.0.0"
"github.com/kardianos/minwinsvc v1.0.0/go.mod"
"github.com/lxn/walk v0.0.0-20210112085537-c389da54e794/go.mod"
"github.com/lxn/win v0.0.0-20210218163916-a377121e959e/go.mod"
"github.com/mattn/go-colorable v0.1.8"
"github.com/mattn/go-colorable v0.1.8/go.mod"
"github.com/mattn/go-isatty v0.0.12/go.mod"
"github.com/mattn/go-isatty v0.0.13"
"github.com/mattn/go-isatty v0.0.13/go.mod"
"github.com/mattn/go-runewidth v0.0.12/go.mod"
"github.com/mattn/go-runewidth v0.0.13"
"github.com/mattn/go-runewidth v0.0.13/go.mod"
"github.com/mitchellh/mapstructure v1.4.1"
"github.com/mitchellh/mapstructure v1.4.1/go.mod"
"github.com/rivo/uniseg v0.1.0/go.mod"
"github.com/rivo/uniseg v0.2.0"
"github.com/rivo/uniseg v0.2.0/go.mod"
"github.com/vishvananda/netlink v1.1.0"
"github.com/vishvananda/netlink v1.1.0/go.mod"
"github.com/vishvananda/netns v0.0.0-20191106174202-0a2b9b5464df/go.mod"
"github.com/vishvananda/netns v0.0.0-20210104183010-2eb08e3e575f"
"github.com/vishvananda/netns v0.0.0-20210104183010-2eb08e3e575f/go.mod"
"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
"golang.org/x/crypto v0.0.0-20210220033148-5ea612d1eb83/go.mod"
"golang.org/x/crypto v0.0.0-20210421170649-83a5a9bb288b/go.mod"
"golang.org/x/crypto v0.0.0-20210506145944-38f3c27a63bf/go.mod"
"golang.org/x/crypto v0.0.0-20210513164829-c07d793c2f9a"
"golang.org/x/crypto v0.0.0-20210513164829-c07d793c2f9a/go.mod"
"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
"golang.org/x/net v0.0.0-20210510120150-4163338589ed/go.mod"
"golang.org/x/net v0.0.0-20210610132358-84b48f89b13b"
"golang.org/x/net v0.0.0-20210610132358-84b48f89b13b/go.mod"
"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
"golang.org/x/sys v0.0.0-20190606203320-7fc4e5ec1444/go.mod"
"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
"golang.org/x/sys v0.0.0-20200217220822-9197077df867/go.mod"
"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
"golang.org/x/sys v0.0.0-20200602225109-6fdc65e7d980/go.mod"
"golang.org/x/sys v0.0.0-20201018230417-eeed37f84f13/go.mod"
"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
"golang.org/x/sys v0.0.0-20210309040221-94ec62e08169/go.mod"
"golang.org/x/sys v0.0.0-20210403161142-5e06dd20ab57/go.mod"
"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
"golang.org/x/sys v0.0.0-20210510120138-977fb7262007/go.mod"
"golang.org/x/sys v0.0.0-20210611083646-a4fc73990273"
"golang.org/x/sys v0.0.0-20210611083646-a4fc73990273/go.mod"
"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221/go.mod"
"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
"golang.org/x/text v0.3.0/go.mod"
"golang.org/x/text v0.3.3/go.mod"
"golang.org/x/text v0.3.6/go.mod"
"golang.org/x/text v0.3.7-0.20210503195748-5c7c50ebbd4f"
"golang.org/x/text v0.3.7-0.20210503195748-5c7c50ebbd4f/go.mod"
"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
"golang.zx2c4.com/wireguard v0.0.0-20210510202332-9844c74f67ec/go.mod"
"golang.zx2c4.com/wireguard v0.0.0-20210604143328-f9b48a961cd2"
"golang.zx2c4.com/wireguard v0.0.0-20210604143328-f9b48a961cd2/go.mod"
"golang.zx2c4.com/wireguard/windows v0.3.14"
"golang.zx2c4.com/wireguard/windows v0.3.14/go.mod"
)

go-module_set_globals

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="https://yggdrasil-network.github.io/"
SRC_URI="
	https://github.com/yggdrasil-network/yggdrasil-go/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="LGPL-3 MIT Apache-2.0 BSD ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="
	acct-user/yggdrasil
	acct-group/yggdrasil
"
RDEPEND=">=dev-vcs/git-1.7.3"
BDEPEND=">=dev-lang/go-1.16"

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
	local PKGSRC="github.com/yggdrasil-network/yggdrasil-go/src/version"
	local PKGNAME="${P}"
	local PKGVER="v${PV}"
	local LDGOFLAGS="-X ${PKGSRC}.buildName=${PKGNAME} -X ${PKGSRC}.buildVersion=${PKGVER}"
	for CMD in yggdrasil yggdrasilctl ; do
		go build -v -x -ldflags="${LDGOFLAGS}" -o ${CMD} ./cmd/${CMD}
	done
}

src_install() {
	dobin {yggdrasil,yggdrasilctl}
	systemd_dounit "contrib/systemd/yggdrasil.service"
	doinitd "contrib/openrc/yggdrasil"
	einstalldocs
}
