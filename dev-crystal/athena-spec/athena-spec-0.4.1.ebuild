# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRYSTAL_MIN_VER="1.17"
inherit shards

MY_PN="${PN#athena-}"
DESCRIPTION="Common/helpful Spec compliant testing utilities"
HOMEPAGE="
	https://github.com/athena-framework/spec
	https://athenaframework.org/Spec/
"
SRC_URI="https://github.com/athena-framework/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_test() {
	# Error: Invalid option: --link-flags=<...>
	local -x CRYSTAL_OPTS=

	shards_src_test
}
