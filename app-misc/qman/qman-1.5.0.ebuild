# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A more modern manual page viewer for our terminals"
HOMEPAGE="https://github.com/plp13/qman"
SRC_URI="https://github.com/plp13/qman/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+doc test"
RESTRICT="!test? ( test )"

DEPEND="
	sys-libs/ncurses:=
	dev-libs/inih
	sys-libs/zlib
"
BDEPEND="
	dev-python/cogapp
	test? (
		dev-util/cunit
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_feature doc docs)
		$(meson_feature test tests)
		-Ddocdir="/usr/share/doc/${PF}"
	)
	meson_src_configure
}
