# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo nimble

DESCRIPTION="A unittest macro to save the world, or at least your Sunday"
HOMEPAGE="https://github.com/disruptek/balls"
SRC_URI="https://github.com/disruptek/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	=dev-nim/grok-0*
	=dev-nim/ups-0*
"

set_package_url "https://github.com/disruptek/balls"

src_test() {
	edo "${BUILD_DIR}"/${PN}
}
