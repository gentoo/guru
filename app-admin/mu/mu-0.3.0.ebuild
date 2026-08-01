# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"
CRATES=""

inherit cargo

DESCRIPTION="Minimal privilege escalation runner"
HOMEPAGE="https://github.com/MulpinKR/mu"
SRC_URI="
	https://github.com/MulpinKR/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/libcrypt:="
RDEPEND="virtual/libcrypt:= !net-mail/mu"

QA_FLAGS_IGNORED="usr/bin/mu"
