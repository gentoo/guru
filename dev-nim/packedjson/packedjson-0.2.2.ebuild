# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="an alternative Nim implementation for JSON"
HOMEPAGE="
	https://github.com/Araq/packedjson
	https://nimble.directory/pkg/packedjson
"
SRC_URI="https://github.com/Araq/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/Araq/packedjson"

src_test() {
	enim r ${PN}.nim | tee "${T}"/tests.out
	grep -q "test failed" "${T}"/tests.out && die "tests failed"
}
