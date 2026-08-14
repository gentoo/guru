# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=" "

inherit cargo

DESCRIPTION="A simple, secure, and modern encryption tool."
HOMEPAGE="https://github.com/str4d/rage"
SRC_URI="
	https://github.com/str4d/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.xz
	https://codeberg.org/ceres-sees-all/guru-distfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD-2 BSD CC0-1.0 CDDL MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

ECARGO_VENDOR="${WORKDIR}/vendor"

QA_FLAGS_IGNORED="
	/usr/bin/${PN}
	/usr/bin/${PN}-keygen
"

PATCHES=( "${FILESDIR}/${P}-keygen-test.patch" )

src_install() {
cargo_src_install --path rage
}
