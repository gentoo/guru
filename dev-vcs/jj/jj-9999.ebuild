# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.84.0"

inherit cargo git-r3

DESCRIPTION="Jujutsu - an experimental version control system"
HOMEPAGE="https://github.com/jj-vcs/jj"
EGIT_REPO_URI="https://github.com/jj-vcs/jj.git"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD MIT MPL-2.0 Unicode-3.0 Unicode-DFS-2016 WTFPL-2
"
SLOT="0"
IUSE="
	+git2
"

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	git2? (
		>=dev-libs/libgit2-1.9.0:0/1.9
		dev-libs/openssl:=
		net-libs/libssh2:=
	)
"
RDEPEND="
	${DEPEND}
	dev-vcs/git
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	export LIBGIT2_NO_VENDOR=1
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
	export OPENSSL_NO_VENDOR=1
	export PKG_CONFIG_ALLOW_CROSS=1
	rust_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	local myfeatures=(
		$(usev git2)
		watchman
		git
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install --path cli
}
