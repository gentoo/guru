# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd toolchain-funcs

EGO_SUM=(
		"github.com/hashicorp/go-syslog v1.0.0"
		"github.com/hashicorp/go-syslog v1.0.0/go.mod"
		"github.com/jedisct1/dlog v0.0.0-20210101122416-354ffe815216"
		"github.com/jedisct1/dlog v0.0.0-20210101122416-354ffe815216/go.mod"
		"github.com/kardianos/service v1.2.0"
		"github.com/kardianos/service v1.2.0/go.mod"
		"github.com/pborman/getopt/v2 v2.1.0"
		"github.com/pborman/getopt/v2 v2.1.0/go.mod"
		"github.com/vishvananda/netlink v1.1.0"
		"github.com/vishvananda/netlink v1.1.0/go.mod"
		"github.com/vishvananda/netlink v1.2.1-beta.2.0.20240713210050-d13535d71ed3"
		"github.com/vishvananda/netlink v1.2.1-beta.2.0.20240713210050-d13535d71ed3/go.mod"
		"github.com/vishvananda/netns v0.0.0-20191106174202-0a2b9b5464df"
		"github.com/vishvananda/netns v0.0.0-20191106174202-0a2b9b5464df/go.mod"
		"github.com/vishvananda/netns v0.0.4"
		"github.com/vishvananda/netns v0.0.4/go.mod"
		"golang.org/x/net v0.23.0"
		"golang.org/x/net v0.23.0/go.mod"
		"golang.org/x/sys v0.0.0-20190606203320-7fc4e5ec1444/go.mod"
		"golang.org/x/sys v0.0.0-20201015000850-e3ed0017c211/go.mod"
		"golang.org/x/sys v0.0.0-20201231184435-2d18734c6014/go.mod"
		"golang.org/x/sys v0.2.0/go.mod"
		"golang.org/x/sys v0.10.0/go.mod"
		"golang.org/x/sys v0.18.0"
		"golang.org/x/sys v0.18.0/go.mod"
		"golang.org/x/sys v0.22.0"
		"golang.org/x/sys v0.22.0/go.mod"
)

go-module_set_globals

DESCRIPTION="A tool for redirecting a given program's TCP traffic to SOCKS5 or HTTP proxy"
HOMEPAGE="https://github.com/hmgle/graftcp"
SRC_URI="https://github.com/hmgle/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

SLOT="0"
LICENSE="GPL-3+"
# Go dependency licenses
LICENSE+=" Apache-2.0 BSD BSD-2 MIT ZLIB"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="acct-user/graftcp"
BDEPEND=">=dev-lang/go-1.21"

PATCHES=(
	"${FILESDIR}"/0002-build-no-longer-strip-symbols.patch
	"${FILESDIR}"/0005-let-graftcp-respect-LDFLAGS.patch
)

DOCS=(
	README{,.zh-CN}.md
	example-{black,white}list-ip.txt
	example-graftcp.conf
	local/example-graftcp-local.conf
)

# Written in golang
QA_FLAGS_IGNORED="
	usr/bin/graftcp-local
	usr/bin/mgraftcp
"

src_compile() {
	local mymakeargs=(
		VERSION="v${PV}"
		CC="$(tc-getCC)"
		AR="$(tc-getAR)"
		CFLAGS="${CFLAGS} -DNDEBUG"
	)
	emake "${mymakeargs[@]}"
}

src_install() {
	local mymakeargs=(
		DESTDIR="${D}"
		PREFIX="${EPREFIX}/usr"
		SYSTEMD_UNIT_DIR="$(systemd_get_systemunitdir)"
	)
	emake -j1 "${mymakeargs[@]}" install install_systemd

	fowners -R root:graftcp /etc/graftcp-local
	fperms 0640 /etc/graftcp-local/graftcp-local.conf

	newinitd "${FILESDIR}"/graftcp-local.initd graftcp-local
	newconfd "${FILESDIR}"/graftcp-local.confd graftcp-local

	einstalldocs
}
