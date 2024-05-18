# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Macro library for Nim"
HOMEPAGE="https://github.com/disruptek/grok"
SRC_URI="https://github.com/disruptek/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/disruptek/grok"
