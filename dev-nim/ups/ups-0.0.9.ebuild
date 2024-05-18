# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="a package handler"
HOMEPAGE="https://github.com/disruptek/ups"
SRC_URI="https://github.com/disruptek/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="<dev-nim/npeg-2.0:*"
DEPEND="test? ( ${RDEPEND} )"
BDEPEND="test? ( dev-nim/balls )"

set_package_url "https://github.com/disruptek/ups"
