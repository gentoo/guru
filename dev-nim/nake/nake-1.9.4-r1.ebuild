# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="make-like for Nim. Describe your builds as tasks!"
HOMEPAGE="https://github.com/fowlmouth/nake"
SRC_URI="https://github.com/fowlmouth/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/libpcre:3"

src_test() {
	local PATH="${BUILD_DIR}:${PATH}"

	cd "${S}"/tests || die
	for t in t*.nim; do
		[[ -f ${t} ]] || continue
		enim --hints:off r "${t}"
	done
}
