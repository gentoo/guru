# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo systemd

EGIT_COMMIT="50318a66f2f2350e99f89e46a1c130d2c01397af"

DESCRIPTION="WebDAV server in Rust"
HOMEPAGE="https://github.com/miquels/webdav-server-rs"
SRC_URI="
	https://github.com/miquels/webdav-server-rs/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="Apache-2.0 BSD ISC MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}"/${P}-use-the-version-0.2.0-of-webdav-handler.patch
)

RDEPEND="
	acct-group/webdav
	acct-user/webdav
	net-libs/libtirpc:=
	sys-libs/pam
"
DEPEND="${RDEPEND}"
BDEPEND="
	net-libs/rpcsvc-proto
"

src_prepare() {
	default

	sed -i "s/uid = 33/uid = $(id -u webdav)/" webdav-server.toml
	sed -i "s/gid = 33/gid = $(id -g webdav)/" webdav-server.toml
}

src_install() {
	cargo_src_install

	insinto "/etc/${PN}"
	newins webdav-server.toml config.toml.example

	systemd_dounit "${FILESDIR}/${PN}.service"
}
