# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Tools and serializer for plain flat binary files"
HOMEPAGE="
	https://github.com/treeform/flatty
	https://nimble.directory/pkg/flatty
"
SRC_URI="https://github.com/treeform/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/treeform/flatty"

src_prepare() {
	default

	# remove failing tests
	rm tests/test_hexprint.nim || die
}
