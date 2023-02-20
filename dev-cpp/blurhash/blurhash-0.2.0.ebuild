# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="C++ blurhash encoder/decoder"
HOMEPAGE="https://github.com/Nheko-Reborn/blurhash"
SRC_URI="https://github.com/Nheko-Reborn/blurhash/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test"

BDEPEND="test? ( dev-cpp/doctest )"

RESTRICT="!test? ( test )"

src_configure() {
	local -a emesonargs=(
		$(meson_use test tests)
	)
	meson_src_configure
}
