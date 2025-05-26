# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="report system wide file access events"
HOMEPAGE="https://github.com/martinpitt/fatrace"
SRC_URI="https://github.com/martinpitt/fatrace/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="powertop"

RDEPEND="powertop? ( sys-power/powertop )"

src_install() {
	dosbin fatrace
	doman fatrace.8
	use powertop && dosbin power-usage-report
	dodoc NEWS
}
