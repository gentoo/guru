# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="A wrapper for the libsass library"
HOMEPAGE="
	https://github.com/dom96/sass
	https://nimble.directory/pkg/sass
"
SRC_URI="https://github.com/dom96/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libsass"
RDEPEND="${DEPEND}"

set_package_url "https://github.com/dom96/sass"
