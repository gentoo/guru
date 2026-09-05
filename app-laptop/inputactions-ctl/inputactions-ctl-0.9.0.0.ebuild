# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="InputActions Control Tool"
HOMEPAGE="https://github.com/InputActions/ctl"
SRC_URI="https://github.com/InputActions/ctl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ctl-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase:6[dbus]
"
DEPEND="
	${RDEPEND}
	dev-cpp/cli11
"
BDEPEND="
	kde-frameworks/extra-cmake-modules
"
