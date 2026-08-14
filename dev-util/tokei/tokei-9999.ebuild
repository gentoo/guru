# Copyright 2017-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.71.1"

CRATES=" "

inherit cargo

DESCRIPTION="Count your code, quickly"
HOMEPAGE="https://github.com/XAMPPRocky/tokei"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/XAMPPRocky/tokei"
else
	SRC_URI="https://github.com/XAMPPRocky/tokei/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
fi

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	BSD ISC MIT MPL-2.0 Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"

SLOT="0"
IUSE="test"
RESTRICT="${RESTRICT} !test? ( test )"

BDEPEND="
	test? (
		virtual/pkgconfig
		>=dev-libs/libgit2-1.1.0
	)
"

QA_FLAGS_IGNORED="usr/bin/tokei"

src_unpack() {
	if [[ "$PV" == *9999* ]];then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	cargo_src_configure --features all
}

src_install() {
	cargo_src_install
	dodoc CHANGELOG.md README.md tokei.example.toml
}
