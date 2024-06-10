# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Jujutsu - an experimental version control system"
HOMEPAGE="https://github.com/martinvonz/jj"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/martinvonz/jj.git"
else
	SRC_URI="
		https://github.com/martinvonz/jj/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"

BDEPEND="virtual/pkgconfig"
DEPEND="
	>=app-arch/zstd-1.5.5:=
	>=dev-libs/libgit2-1.7.2:=
	dev-libs/openssl
	net-libs/libssh2:=
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	export LIBGIT2_NO_VENDOR=1
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
	export OPENSSL_NO_VENDOR=1
	export PKG_CONFIG_ALLOW_CROSS=1
	export ZSTD_SYS_USE_PKG_CONFIG=1
}

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install --path cli
}
