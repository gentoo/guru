# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Markdown based personal knowledge management (PKM) system"
HOMEPAGE="https://github.com/iwe-org/iwe"
SRC_URI="
	https://github.com/iwe-org/iwe/archive/refs/tags/iwe-v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/liwe-v${PV}/${PN}-liwe-v${PV}-deps.tar.xz
"

S="${WORKDIR}/${PN}-${PN}-v${PV}"

LICENSE="Apache-2.0 BSD CDLA-Permissive-2.0 ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	cargo_src_install --path crates/iwe
	cargo_src_install --path crates/iwes
	dodoc LICENSE-APACHE README.md
}
