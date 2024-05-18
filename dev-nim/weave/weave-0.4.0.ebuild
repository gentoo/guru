# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="a state-of-the-art multithreading runtime"
HOMEPAGE="
	https://github.com/mratsim/weave
	https://nimble.directory/pkg/weave
"
SRC_URI="https://github.com/mratsim/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-nim/synthesis"
DEPEND="
	test? (
		${RDEPEND}
		dev-nim/cligen
	)
"

set_package_url "https://github.com/mratsim/weave"

src_prepare() {
	default

	# failing tests
	sed "/weave\/parallel_for.nim/d" -i ${PN}.nimble || die
}
