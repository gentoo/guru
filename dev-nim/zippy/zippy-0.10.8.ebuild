# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Pure Nim implementation of deflate, zlib, gzip and zip"
HOMEPAGE="
	https://github.com/guzba/zippy
	https://nimble.directory/pkg/zippy
"
SRC_URI="https://github.com/guzba/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/guzba/zippy"
