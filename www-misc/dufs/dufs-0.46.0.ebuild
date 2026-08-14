# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.87.0"

CRATES=" "

inherit cargo

DESCRIPTION="Dufs is a distinctive utility file server"
HOMEPAGE="https://github.com/sigoden/dufs"
SRC_URI="
	https://github.com/sigoden/dufs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/ceres-sees-all/guru-distfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Rust package
QA_FLAGS_IGNORED="usr/bin/${PN}"

ECARGO_VENDOR="${WORKDIR}/vendor"
